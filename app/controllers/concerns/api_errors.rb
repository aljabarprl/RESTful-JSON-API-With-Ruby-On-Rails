module ApiErrors
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class ExpiredSignature < StandardError; end
  
  class InvalidCredentials < StandardError; end 
  class AuthenticationError < StandardError; end 
end