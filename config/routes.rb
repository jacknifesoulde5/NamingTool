Rails.application.routes.draw do
  get 'users/index'
  delete 'users/index/:id', to: 'users#destroy'
  devise_for :users
  resources :tool
  post 'tool_other', to: 'tool#conv_other'
  resources :words
end
