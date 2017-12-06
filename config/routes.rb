Rails.application.routes.draw do

  ActiveAdmin.routes(self)

  get '/:provider/results', to: 'results#index'

  devise_for :users
  root to: 'pages#home'

  get '/auth/:provider/callback', to: 'providers#create'

end
