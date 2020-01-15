Rails.application.routes.draw do
  #root to: "tool#index"
  resources :tool
  post 'tool_other', to: 'tool#conv_other'
  resources :words
end
