Rails.application.routes.draw do
  resources :contests do
    resources :competitions, except: [:index]
  end
  resources :payments
  resources :shooters
  resources :sessions, only: [:new, :create, :destroy]
  root 'contests#index'
  get 'names.json', to: 'shooters#names'
  match '/signin', to: 'sessions#new', via: :get, as: 'signin'
  match '/signout', to: 'sessions#destroy', via: :delete, as: 'signout'
end
