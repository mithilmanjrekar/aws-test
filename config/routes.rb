Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  post 'upload_image' => 'visitors#upload_image'

end
