def lambda_handler(event:, context:)
    method = event['httpMethod']
    if method == 'PUT'
    elsif method == 'POST'
    elsif method == 'GET'
    else
      {
        statusCode: 405,
        body: JSON.generate({
          error: "Method not allowed: #{method}"
        })
      }
    end
  end