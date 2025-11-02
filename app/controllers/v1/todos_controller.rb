module V1

    # class TodosController < ApplicationController
    class TodosController < BaseController
    before_action :authorize_request
    before_action :set_todo, only: [:show, :update, :destroy]

    # GET /todos
    def index
        # @todos = current_user.todos.paginate(page: params[:page], per_page: 20)
        # @todos = current_user.todos.page(params[:page])
        page_num = params[:page] || 1
        per_page_count = params[:per_page] || 20
        # @todos = current_user.todos.all
        @todos = current_user.todos.paginate(page: page_num, per_page: per_page_count)
        json_response(@todos)
    end

    # POST /todos
    def create
        @todo = current_user.todos.create!(todo_params)
        json_response(@todo, :created)
    end

    # GET /todos/:id
    def show
        json_response(@todo)
    end

    # PUT /todos/:id
    def update
        @todo.update!(todo_params)
        head :no_content
    end

    # DELETE /todos/:id
    def destroy
        @todo.destroy
        head :no_content
    end

    private

    def todo_params
        params.permit(:title)
    end

    def set_todo
        @todo = current_user.todos.find(params[:id])
    end
    end

end