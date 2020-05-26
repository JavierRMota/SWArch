require 'aws-sdk-dynamodb'
require 'json'

class HttpStatus
  OK = 200
  CREATED = 201
  ACCEPTED = 202
  BAD_REQUEST = 400
  METHOD_NOT_ALLOWED = 405
  NOT_FOUND = 404
end
DYNAMODB = Aws::DynamoDB::Client.new
TABLE_NAME = 'QuizScores'
NUMBER_OF_QUESTIONS  = 40
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
def handle_put(body)
end
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
    DYNAMODB.put_item({
      table_name: TABLE_NAME,
      item:{
        questions: questions,
        name: name
      }
    })
    {
      statusCode: HttpStatus::CREATED,
      body: JSON.generate({
        questions: questions
      })
    }
  else
    {
      statusCode: HttpStatus::BAD_REQUEST,
      body: JSON.generate({
        error: "Must enter a valid name and number of questions"
      })
    }
  end
end
def handle_get
  response = DYNAMODB.scan(table_name: TABLE_NAME)
  items = response.items.map{ |item|
    item['questions'] = item['questions'].map{|question|
      question.to_i
    }
    item
  }
  {
    statusCode: HttpStatus::OK,
    body: JSON.generate({
      scores: items
    })
  }
end
def lambda_handler(event:, context:)
    method = event['httpMethod']
    if method == 'PUT'
      body = parse_body(event['body'])
      handle_put(body)
    elsif method == 'POST'
      body = parse_body(event['body'])
      handle_post(body)
    elsif method == 'GET'
      handle_get
    else
      {
        statusCode: HttpStatus::METHOD_NOT_ALLOWED,
        body: JSON.generate({
          error: "Method not allowed: #{method}"
        })
      }
    end
  end