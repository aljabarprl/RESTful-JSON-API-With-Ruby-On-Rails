module V2
  class TodosController < ApplicationController
    skip_before_action :authorize_request, only: [:index] 
    def index
      render json: [].to_json, status: :ok 
    end
  end
end