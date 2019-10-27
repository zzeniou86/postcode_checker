Rails.application.routes.draw do
  get '/postcodes', to: 'postcodes#index'

  root 'postcodes#index'
end
