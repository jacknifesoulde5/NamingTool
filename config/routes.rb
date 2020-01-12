Rails.application.routes.draw do
  #root to: "tool#index"
  resources :tool
  resources :words
end
