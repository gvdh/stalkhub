require "sidekiq/web"

Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  get '/:provider/results', to: 'results#index', as: 'results'

  devise_for :users
  root to: 'pages#home'
  get '/auth/:provider/callback', to: 'providers#create'

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
