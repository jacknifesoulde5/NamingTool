Rails.application.routes.draw do
  controller :users do
    get 'users/index'
    delete 'users/index/:id', to: 'users#destroy'
    devise_for :users
  end

  controller :tool do
    resources :tool, :only => :index
    post 'conv_method', to: 'tool#conv_method'
    post 'conv_other', to: 'tool#conv_other'
    get 'get_concrete/:id', to: 'tool#get_concrete',as: 'get_concrete'
  end

  controller :words do
    resources :words, :except => :show
  end
end
