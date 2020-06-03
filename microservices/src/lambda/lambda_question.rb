# Date: 09-Jun-2020
# File: lambda_question.rb
# Authors: A01372812 José Javier Rodríguez Mota
#          A01379228 Adrián Méndez López

require 'json'
require 'yaml'

# Questions file content constant
QUESTIONS = YAML.load_file('Pool.yml')

# Returns the appropiate answer for a given
# question passed through the query parameters
# of the request and using method get.
# Returns status code 200 if the query
# was succesful, or the corresponding error code.
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