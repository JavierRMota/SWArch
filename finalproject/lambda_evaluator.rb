require 'json'
require 'yaml'

ANSWERS = YAML.load_file('Evaluator.yml')

def lambda_handler(event:, context:)
  method = event['httpMethod']
  if method == 'POST'
    query_string = event['queryStringParameters'] || {}
    if query_string['id'] && query_string['answer']
      id = query_string['id'].to_i
      if 0 <= id and id < ANSWERS.size
        answer = ANSWER[id]['answer']
        {
          statusCode: 200,
          body: JSON.pretty_generate({
            id: id,
            answer: answer,
            correct: answer == query_string['answer']
          })
        }
      else
        { statusCode: 404,
          body: JSON.generate({
            error: "ID #{id} not found"
          })
        }
      end
    else
      { 
        statusCode: 400,
        body: JSON.generate({
          error: "ID is required."
        })
      }
    end
  else
    {
      statusCode: 405,
      body: JSON.generate({
        error: "Method not allowed: #{method}"
      })
    }
  end
end