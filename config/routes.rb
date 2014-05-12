Rails.application.routes.draw do
  resources :contests do
    resources :competitions, only: [:new, :create]
  end
  resources :payments, only: [:index]
  resources :shooters
  root 'contests#index'
end
