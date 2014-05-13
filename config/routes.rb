Rails.application.routes.draw do
  resources :contests do
    resources :competitions, only: [:new, :create]
  end

  resources :payments, only: [:index, :show]
  resources :shooters, only: [:index]
  root 'contests#index'
end
