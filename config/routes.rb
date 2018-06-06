Rails.application.routes.draw do


  
  resources :categories
  resources :products
  resources :questions do
    resources :answers
  end
  resources :types
  resources :pets
  root to: "home#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' ,omniauth_callbacks: 'users/omniauth' }
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
