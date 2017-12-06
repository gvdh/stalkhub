Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :results, only: [ :fb_index, :fb_index_photo, :fb_index_text, :fb_index_video ]
  get '/facebook/results', to: 'results#fb_index'
  get '/facebook/results/photos', to: 'results#fb_index_photo'
  get '/facebook/results/texts', to: 'results#fb_index_text'
  get '/facebook/results/videos', to: 'results#fb_index_video'

  devise_for :users
  root to: 'pages#home'

  get '/auth/:provider/callback', to: 'providers#create'

end
