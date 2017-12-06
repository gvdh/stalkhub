Rails.application.routes.draw do

  resources :results, only: [ :index, :index_photo, :index_text, :index_video ]

  devise_for :users
  root to: 'pages#home'

  get '/auth/:provider/callback', to: 'providers#create'

end
