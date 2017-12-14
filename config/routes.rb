require "sidekiq/web"

Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  root to: 'pages#home'
  get '/:provider/destroy', to: 'results#destroy', as: 'destroy_results'
  get '/:provider/results', to: 'results#index', as: 'results'
  get '/:provider/connect', to: 'providers#new', as: 'new_provider'

  devise_for :users

  get '/auth/:provider/callback', to: 'providers#create'

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
