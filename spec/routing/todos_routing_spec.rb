require "rails_helper"

RSpec.describe V1::TodosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/todos").to route_to("v1/todos#index")
    end

    it "routes to #show" do
      expect(get: "/todos/1").to route_to("v1/todos#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "/todos").to route_to("v1/todos#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/todos/1").to route_to("v1/todos#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/todos/1").to route_to("v1/todos#destroy", id: "1")
    end
    
    it "routes items index" do
        expect(get: "/todos/1/items").to route_to("v1/items#index", todo_id: "1")
    end
  end
end
