Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end 

  resources :tool
  post 'tool_other', to: 'tool#conv_other'
  resources :words
end
