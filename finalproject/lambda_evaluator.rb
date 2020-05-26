require 'json'
require 'yaml'

ANSWERS = YAML.load_file('Evaluator.yml')
class HttpStatus
  OK = 200
  CREATED = 201
  ACCEPTED = 202
  BAD_REQUEST = 400
  METHOD_NOT_ALLOWED = 405
  NOT_FOUND = 404
end
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
def lambda_handler(event:, context:)
  method = event['httpMethod']
  if method == 'POST'
    body = parse_body(event['body'])
    if body['id'] && body['answer']
      id = body['id'].to_i
      if 0 <= id and id < ANSWERS.size
        answer = ANSWERS[id]['answer']
        {
          statusCode: HttpStatus::OK,
          body: JSON.pretty_generate({
            id: id,
            answer: answer,
            correct: answer == body['answer']
          })
        }
      else
        { statusCode: HttpStatus::NOT_FOUND,
          body: JSON.generate({
            error: "ID #{id} not found"
          })
        }
      end
    else
      { 
        statusCode: HttpStatus::BAD_REQUEST,
        body: JSON.generate({
          error: "ID is required."
        })
      }
    end
  else
    {
      statusCode: HttpStatus::METHOD_NOT_ALLOWED,
      body: JSON.generate({
        error: "Method not allowed: #{method}"
      })
    }
  end
end