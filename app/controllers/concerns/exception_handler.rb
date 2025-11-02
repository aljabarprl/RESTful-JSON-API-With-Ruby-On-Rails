module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ActiveRecord::RecordNotFound, with: :four_zero_four
    rescue_from ApiErrors::MissingToken, with: :four_zero_one
    rescue_from ApiErrors::InvalidToken, with: :four_zero_one
    rescue_from ApiErrors::ExpiredSignature, with: :four_zero_one
    rescue_from ApiErrors::InvalidCredentials, with: :four_zero_one
    rescue_from ActionController::ParameterMissing, with: :four_twenty_two
  end

  private

  # code 422 = unprocessable entity
  def four_zero_four(e)
    json_response({ message: e.message }, :not_found)
  end

  # (Unprocessable Entity)
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end
  
  # (Unauthorized/Missing Token/Invalid Token)
  def four_zero_one(e)
    json_response({ message: e.message }, :unauthorized)
  end
end