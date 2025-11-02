require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  
  let(:user) { create(:user) }
  
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  
  subject(:valid_request_obj) { described_class.new(header) }
  subject(:invalid_request_obj) { described_class.new({}) }

  let(:expired_token) { token_generator(user.id, (Time.now.to_i - 10)) }
  let(:expired_header) { { 'Authorization' => expired_token } }
  subject(:expired_request_obj) { described_class.new(expired_header) }

  describe '#call' do
    context 'when valid request' do
      it 'returns user object' do
        result = valid_request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    context 'when invalid request' do
      
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ApiErrors::MissingToken, Message.missing_token)
        end
      end

      context 'when invalid token' do
        let(:header) { { 'Authorization' => token_generator(5) } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ApiErrors::InvalidToken, /Invalid token/)
        end
      end
      
      context 'when token is expired' do
        it 'raises ExpiredSignature error' do
          expect { expired_request_obj.call }
            .to raise_error(
              ApiErrors::ExpiredSignature,
              /Signature has expired/ 
            )
        end
      end

      context 'fake token' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'handles JWT::DecodeError' do
          expect { invalid_request_obj.call }
            .to raise_error(
              ApiErrors::InvalidToken,
              /Not enough or too many segments/
            )
        end
      end
    end
  end
end