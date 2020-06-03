# Date: 09-Jun-2020
# File: lambda_evaluator.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'json'
require 'yaml'
require './lambda/http_status'

# Answer file content constant
ANSWERS = YAML.load_file('Evaluator.yml')

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

# Returns the appropiate answer for a given
# question passed through the body of the
# request and using method post.
# Returns status code 200 if the query
# was succesful, or the corresponding error code.
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