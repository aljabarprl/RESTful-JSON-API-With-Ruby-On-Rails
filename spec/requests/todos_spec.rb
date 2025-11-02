require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  let!(:user) { create(:user) }
  let!(:todos) { create_list(:todo, 10, user_id: user.id) } 
  
  let(:todo_id) { todos.first.id }
    
  let!(:other_user) { create(:user) } 
  let!(:other_todo) { create(:todo, user: other_user) }

  let(:api_v1_headers) { { 'Accept' => 'application/vnd.todos.v1+json' } }
  
  let(:headers) { valid_headers(user.id).merge(api_v1_headers) }
 
  let(:invalid_headers) { { 'Authorization' => nil }.merge(api_v1_headers) }
  
  describe 'GET /todos' do
    before { get '/todos', params: {}, headers: headers }

    it 'returns todos created by the current user only' do
      expect(json['todos'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'Unauthenticated Requests' do
    before { get '/todos', params: {}, headers: invalid_headers }

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end

    it 'returns a missing token message' do
      expect(json['message']).to match(/Missing token/)
    end
  end

  describe 'GET /todos/:id' do
    context 'when the record exists and belongs to the user' do
      before { get "/todos/#{todo_id}", params: {}, headers: headers }

      it 'returns the todo' do
        expect(json).not_to be_empty
    
        expect(json['todo']['id']).to eq(todo_id)
        
        expect(json['todo']['title']).to eq(todos.first.title) 
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    
    context 'when the record exists but NOT belong to the user (scoping test)' do
      before { get "/todos/#{other_todo.id}", params: {}, headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to match(/Couldn't find Todo/)
      end
    end

    context 'when the record does not exist' do
      let(:todo_id) { 100 }
      before { get "/todos/#{todo_id}", params: {}, headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'POST /todos' do
    let(:valid_attributes) { { title: 'Belajar Ruby' }.to_json }
    
    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes, headers: headers }

      it 'creates a todo' do
        expect(json['todo']['title']).to eq('Belajar Ruby')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'assigns the todo to the current user' do
        expect(Todo.last.user).to eq(user)
      end
    end

    context 'when the request is invalid (missing title)' do
      let(:invalid_attributes) { { title: nil }.to_json }
      before { post '/todos', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json['message']).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Belajar JavaScript' }.to_json }

    context 'when the record exists and belongs to the user' do
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
    
    context 'when the record does not exist' do
      let(:todo_id) { 100 }
      before { put "/todos/#{todo_id}", params: valid_attributes, headers: headers }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    context 'when the record exists and belongs to the user' do
      before { delete "/todos/#{todo_id}", params: {}, headers: headers }

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'removes the todo from the database' do
        expect(Todo.find_by(id: todo_id)).to be_nil
      end
    end
  end
end