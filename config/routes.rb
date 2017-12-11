require "sidekiq/web"

Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  get '/:provider/results', to: 'results#index', as: 'results'
  get '/:provider/connect', to: 'providers#new', as: 'new_provider'

  devise_for :users
  root to: 'pages#home'
  get '/auth/:provider/callback', to: 'providers#create'
  get '/:provider/initializer', to: 'providers#create_for_instagram', as: 'initializer_provider'

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
