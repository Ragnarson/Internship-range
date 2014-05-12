Rails.application.routes.draw do
  resources :contests
  resources :payments, only: [:index]
  resources :shooters
  root 'contests#index'
end
