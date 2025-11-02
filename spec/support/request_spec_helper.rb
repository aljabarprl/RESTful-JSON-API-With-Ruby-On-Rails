module RequestSpecHelper
  # Parse JSON response to ruby hash

  def valid_headers(user)
  end

  def invalid_headers
    {
      'Authorization' => nil, 
      'Content-Type' => 'application/json'
    }
  end

  def invalid_headers_token
    {
      'Authorization' => "Bearer invalid.token.here",
      'Content-Type' => 'application/json'
    }
  end
  
  def json
    JSON.parse(response.body)
  end

  def api_v1_headers
    { 'Accept' => 'application/vnd.todos.v1+json' }
  end
end 