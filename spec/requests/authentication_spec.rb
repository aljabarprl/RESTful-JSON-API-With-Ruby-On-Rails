require 'rails_helper'

RSpec.describe 'Authentications', type: :request do
 
  let!(:user) { create(:user) }

  let(:auth_headers) { { 'Content-Type' => 'application/json' }.merge(api_v1_headers) }
  
  let(:url) { '/auth/login' }

  let(:valid_credentials) do
    {
      email: user.email,
      password: user.password
    }.to_json
  end

  let(:invalid_credentials) do
    {
      email: Faker::Internet.email,
      password: Faker::Internet.password
    }.to_json
  end

  context 'When request is valid' do
    before { post url, params: valid_credentials, headers: auth_headers }

    it 'returns an authentication token' do
      expect(json['auth_token']).not_to be_nil
    end
  end

  context 'When request is invalid' do
    before { post url, params: invalid_credentials, headers: auth_headers }

    it 'returns failure message' do
      expect(json['message']).to match(/Invalid credentials/)
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end
  end
end