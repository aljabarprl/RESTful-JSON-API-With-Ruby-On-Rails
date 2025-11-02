class JsonWebToken
  # secret to encode and decode token
  unless defined?(HMAC_SECRET)
    HMAC_SECRET = Rails.application.config.secret_key_base 
  end

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i

    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
  
  rescue JWT::DecodeError => e
    raise ApiErrors::ExpiredSignature, e.message if e.is_a? JWT::ExpiredSignature
    raise ApiErrors::InvalidToken, e.message
  
  rescue JWT::ExpiredSignature => e
    raise ApiErrors::ExpiredSignature, e.message
  end
end