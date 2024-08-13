Rails.application.routes.draw do
  devise_for :users, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"

  devise_scope :user do
    resources :vat_codes
    get 'vat_codes/poll', to: 'vat_codes#poll', as: 'vat_codes_poll'
  end
end
