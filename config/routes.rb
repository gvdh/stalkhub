require "sidekiq/web"

Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :results, only: [ :index, :index_photo, :index_text, :index_video ]

  devise_for :users
  root to: 'pages#home'

  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
