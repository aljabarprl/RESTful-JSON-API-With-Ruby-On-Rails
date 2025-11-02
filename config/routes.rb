# Rails.application.routes.draw do
#   resources :items
#   resources :todos
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Defines the root path route ("/")
#   # root "posts#index"
# end

Rails.application.routes.draw do
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'v1/users#create'

  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :users, only: [:create, :show, :index]
    resources :todos do
      resources :items
    end
  end

  namespace :v2 do
    resources :todos, only: [:index]
  end
end