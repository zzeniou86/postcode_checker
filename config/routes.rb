Rails.application.routes.draw do
  get '/postcodes', to: 'postcodes#index'
  post '/postcodes/check_whitelist', to: 'postcodes#check_whitelist'

  root 'postcodes#index'
end
