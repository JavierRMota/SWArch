require 'json'
require 'yaml'

QUESTIONS = YAML.load_file('Pool.yml')
class HttpStatus
  OK = 200
  CREATED = 201
  ACCEPTED = 202
  BAD_REQUEST = 400
  METHOD_NOT_ALLOWED = 405
  NOT_FOUND = 404
end
def lambda_handler(event:, context:)
  method = event['httpMethod']
  if method == 'GET'
    query_string = event['queryStringParameters'] || {}
    if query_string['id']
      id = query_string['id'].to_i
      if 0 <= id and id < QUESTIONS.size
        {
          statusCode: HttpStatus.OK,
          body: JSON.pretty_generate({
            id: id,
            question: QUESTIONS[id]['question'],
            A: QUESTIONS[id]['A'],
            B: QUESTIONS[id]['B'],
            C: QUESTIONS[id]['C'],
            D: QUESTIONS[id]['D']
          })
        }
      else
        { statusCode: HttpStatus.NOT_FOUND,
          body: JSON.generate({
            error: "ID #{id} not found"
          })
        }
      end
    else
      { 
        statusCode: HttpStatus.BAD_REQUEST,
        body: JSON.generate({
          error: "ID is required."
        })
      }
    end
  else
    {
      statusCode: HttpStatus.METHOD_NOT_ALLOWED,
      body: JSON.generate({
        error: "Method not allowed: #{method}"
      })
    }
  end
end