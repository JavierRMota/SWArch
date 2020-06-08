# Date: 09-Jun-2020
# File: lambda_score.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'aws-sdk-dynamodb'
require 'json'

#Dynamodb client constant
DYNAMODB = Aws::DynamoDB::Client.new
#Dynamodb table name constant
TABLE_NAME = 'QuizScores'
#Max number of questions constant
NUMBER_OF_QUESTIONS  = 40

# Returns the body as a Hash or Json Object
def parse_body(body)
  if body
    if body.is_a?(Hash)
      body
    else
      begin
        data = JSON.parse(body)
        data
      rescue JSON::ParserError
        {}
      end
    end
  else
    {}
  end
end

# Returns the updated score for a given
# quiz passed through the body
# of the request and using method put.
# Returns status code 202 if the query
# was succesful, or the corresponding error code.
def handle_put(body)
  if (body.key?('name') && body.key?('time') && body.key?('question') && body.key?('answer'))
    name = body['name']
    time = body['time']
    question = body['question']
    answer = body['answer']
    begin
      result = DYNAMODB.get_item({
        table_name: TABLE_NAME,
        key:{ name: name }
      })
      quizzes = result.item['quizzes']
      if (quizzes.key?("#{time}"))
        quiz = quizzes["#{time}"]
        quiz['questions'] = quiz['questions'].map{ |question|
          question.to_i
        }
        quiz['answers'] = quiz['answers'].map{ |answers|
          answers.to_i
        }
        if (quiz['questions'].include?(question) && !quiz['answers'].include?(question))
          if (answer)
            quiz['score'] = quiz['score'].to_i + 1
          end
          quiz['answers'] << question
        end
        quizzes["#{time}"] = quiz
        DYNAMODB.update_item({
          table_name: TABLE_NAME,
          key:{ name: name },
          update_expression: 'set quizzes = :q',
          expression_attribute_values: {':q' => quizzes},
          return_values: 'UPDATED_NEW'
        })
        {
          statusCode: HttpStatus::ACCEPTED,
          body: JSON.generate({
            name: name,
            req_time: time,
            score: quiz['score'],
            questions:  quiz['questions'].reject{|x|  quiz['answers'].include? x}
          })
        }
      else
        {
          statusCode: HttpStatus::NOT_FOUND,
          body: JSON.generate({
            error: "Quiz not fount"
          })
        }
      end
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      {
        statusCode: HttpStatus::ERROR,
        body: JSON.generate({
          error: error
        })
      }
    end
  else
    {
      statusCode: HttpStatus::BAD_REQUEST,
      body: JSON.generate({
        error: "Must enter all values"
      })
    }
  end
end

# Returns a new quiz for a given
# user passed through the body
# of the request and using method post.
# Returns status code 201 if the query
# was succesful, or the corresponding error code.
def handle_post(body)
  if (body['name'] &&  body['questions'])
    all = (0..(NUMBER_OF_QUESTIONS - 1)).to_a
    number = body['questions'].to_i
    name = body['name']
    questions = Array.new
    if (number > 40)
      number = 40
    end
    if (number == 40)
      questions = all.shuffle
    else
      i = 0
      loop do
        if (i == number)
          break
        end
        question = rand(all.length)
        questions << all[question]
        all.delete_at(question)
        i += 1
      end
    end
    quizzes = {}
    req_time = Time.now.to_i
    begin
      result = DYNAMODB.get_item({
        table_name: TABLE_NAME,
        key:{ name: name }
      })
      if result.item.nil?
        quizzes["#{req_time}"]= {
          questions: questions,
          answers:[],
          score: 0
        }
        DYNAMODB.put_item({
          table_name: TABLE_NAME,
          item:{
            quizzes: quizzes,
            name: name,
          }
        })
      else
        quizzes = result.item["quizzes"]
        quizzes["#{req_time}"]= {
          questions: questions,
          answers:[],
          score: 0
        }
        DYNAMODB.update_item({
          table_name: TABLE_NAME,
          key:{ name: name },
          update_expression: 'set quizzes = :q',
          expression_attribute_values: {':q' => quizzes},
          return_values: 'UPDATED_NEW'
        })
      end
      {
        statusCode: HttpStatus::CREATED,
        body: JSON.generate({
          questions: questions,
          req_time: req_time
        })
      }
    rescue  Aws::DynamoDB::Errors::ServiceError => error
      {
        statusCode: HttpStatus::ERROR,
        body: JSON.generate({
          error: "Something went wrong"
        })
      }
    end
  else
    {
      statusCode: HttpStatus::BAD_REQUEST,
      body: JSON.generate({
        error: "Must enter a valid name and number of questions"
      })
    }
  end
end

# Returns the quizzes for a given
# user passed through the query parameters
# of the request and using method get.
# Returns all quizzes and users if no
# query given.
# Returns status code 200 if the query
# was succesful, or the corresponding error code.
def handle_get(query)
  if (query && query['name'] && query['quiz'])
    name = query['name']
    quiz =  query['quiz']
    result = DYNAMODB.get_item({
        table_name: TABLE_NAME,
        key:{ name: name }
      })
      if result.item.nil? || !result.item['quizzes'].key?(quiz)
        {
          statusCode: HttpStatus::NOT_FOUND,
          body: JSON.generate({
            error: "Cannot find quiz #{quiz} from #{name}"
          })
        }
      else
        item = result.item['quizzes'][quiz]
        item['questions'] = item['questions'].map { |question|
          question.to_i
        }
        item['answers'] = item['answers'].map { |answer|
          answer.to_i
        }
        item['score'] = item['score'].to_i
        {
          statusCode: HttpStatus::OK,
          body: JSON.generate({
            name: name,
            req_time: quiz,
            score: item['score'].to_i,
            questions:  item['questions'].reject{|x|  item['answers'].include? x}
          })
        }
      end
  else
    response = DYNAMODB.scan(table_name: TABLE_NAME)
    items = response.items.map{ |item|
      item['quizzes'].each do |key, quiz|
        quiz['questions'] = quiz['questions'].map { |question|
          question.to_i
        }
        quiz['answers'] = quiz['answers'].map { |answer|
          answer.to_i
        }
        quiz['score'] = quiz['score'].to_i
      end
      item
    }
    {
      statusCode: HttpStatus::OK,
      body: JSON.generate({
        scores: items
      })
    }
  end
end

# Reads the event and assigns the
# appropiate method to respond.
def lambda_handler(event:, context:)
    method = event['httpMethod']
    if method == 'PUT'
      body = parse_body(event['body'])
      handle_put(body)
    elsif method == 'POST'
      body = parse_body(event['body'])
      handle_post(body)
    elsif method == 'GET'
      handle_get(event['queryStringParameters'])
    else
      {
        statusCode: HttpStatus::METHOD_NOT_ALLOWED,
        body: JSON.generate({
          error: "Method not allowed: #{method}"
        })
      }
    end
end