require 'rails_helper'

RSpec.describe 'Items API', type: :request do
  
  let!(:user) { create(:user) }
  let!(:todo) { create(:todo, user: user) }
  
  
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }
  
  let(:api_v1_headers) { { 'Accept' => 'application/vnd.todos.v1+json' } }
  let(:headers) { valid_headers(user.id).merge(api_v1_headers) }
 
  let(:invalid_headers) { { 'Authorization' => nil }.merge(api_v1_headers) }

  describe 'GET /todos/:todo_id/items' do
    context 'when todo exists (authenticated)' do
      let!(:items) { create_list(:item, 20, todo_id: todo_id) }
      before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all todo items' do
        expect(json['items'].size).to eq(20)
      end
    end

    context 'when not authenticated' do
      before { get "/todos/#{todo_id}/items", params: {}, headers: invalid_headers }
      
      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }
      before { get "/todos/#{todo_id}/items", params: {}, headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'GET /todos/:todo_id/items/:id' do
    context 'when todo item exists' do
      let!(:items) { create_list(:item, 20, todo_id: todo_id) }
      before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the item' do
        expect(json['item']['id']).to eq(id)
        expect(json['item']['id']).to be_present
      end
    end

    context 'when todo item does not exist' do
      let(:id) { 0 }
      before { get "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json['message']).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Narnia', done: false }.to_json }
    let(:invalid_attributes) { { name: nil }.to_json }

    context 'when valid request' do
      let!(:items) { create_list(:item, 20, todo_id: todo_id) }
      before do
        post "/todos/#{todo_id}/items", params: valid_attributes, headers: headers
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        expect(json['item']['id']).to be_present
      end
    end

    context 'when invalid request' do
      before do
        post "/todos/#{todo_id}/items", params: invalid_attributes, headers: headers
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Mozart' }.to_json }
    
    context 'when item exists' do
      let!(:items) { create_list(:item, 20, todo_id: todo_id) }
      before do
        put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers
      end

      it 'returns status code 204 (No Content)' do
        expect(response).to have_http_status(204)
      end

      it 'updates the item' do
        updated_item = Item.find(id)
        expect(updated_item.name).to match(/Mozart/)
      end
    end

    context 'when item does not exist' do
      let(:id) { 0 }
      before do
        put "/todos/#{todo_id}/items/#{id}", params: valid_attributes, headers: headers
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /todos/:todo_id/items/:id' do
    let!(:items) { create_list(:item, 20, todo_id: todo_id) }
    before { delete "/todos/#{todo_id}/items/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the item from the database' do
      expect { Item.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
