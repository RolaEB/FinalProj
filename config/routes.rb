Rails.application.routes.draw do
  get "settings/payment-info/users/auth/stripe_connect/callback", to:"event#stripe_callback"
  #get 'event/stripe_callback'

  get 'event/payment_profile'

  resources :services
  resources :service_categories
  root to: "home#index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { registrations: 'registrations' ,omniauth_callbacks: 'users/omniauth' }

  resources :charges
  resources :posters
  resources :categories
  resources :products do
    resources :reviews
  end
  resources :questions do
    resources :answers
  end
  resources :types
  resources :pets
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
