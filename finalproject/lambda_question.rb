require 'json'
require 'yaml'

QUESTIONS = YAML.load_file('Pool.yml')

def lambda_handler(event:, context:)
  method = event['httpMethod']
  if method == 'GET'
    query_string = event['queryStringParameters'] || {}
    if query_string['id']
      id = query_string['id'].to_i
      if 0 <= id and id < QUESTIONS.size
        {
          statusCode: 200,
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