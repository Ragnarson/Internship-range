Rails.application.routes.draw do
  resources :contests
  resources :payments, only: [:index]
  root 'contests#index'
end
