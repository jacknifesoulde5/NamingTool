Rails.application.routes.draw do
  get 'users/index'
  delete 'users/index/:id', to: 'users#destroy'
  devise_for :users
  resources :tool
  post 'conv_method', to: 'tool#conv_method'
  post 'conv_other', to: 'tool#conv_other'
  get 'get_concrete/:id', to: 'tool#get_concrete',as: 'get_concrete'
  resources :words
end
