Rails.application.routes.draw do
  resources :user_track_logs
  resources :users
  resources :porducts
  root to: 'signup#home'

  match '/sign_up' , :to => 'admin#new',via: [:get, :post]
  match '/users/check_availability' , :to => 'users#check_availability',via: [:get, :post]
  match "/login", :to => "sessions#new" ,via: [:get, :post]
  match "/logout" ,:to => "sessions#destroy", :as => "logout", via: [:get, :post]
  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
