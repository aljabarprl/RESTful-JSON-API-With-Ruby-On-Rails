require 'rails_helper'

RSpec.describe 'V2::Todos', type: :request do
  let(:path) { '/v2/todos' } 
  let(:headers) { { 'Accept' => 'application/json' } } 
  
  describe 'GET /index' do
    before { get path, headers: headers } 

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
    
    it 'returns an empty array' do
      expect(json).to eq([])
    end
  end
end