Rails.application.routes.draw do
  resources :contests do
    member do
      get :select
    end
    resources :competitions, except: [:index, :new]
  end
  resources :users
  resources :payments
  resources :shooters
  resources :app_configs, path: '/settings', only: [:index, :update]
  resources :sessions, only: [:new, :create, :destroy]
  root 'shooters#index'
  get 'names.json', to: 'shooters#names'
  get 'contests_archive', to: 'contests#index_archive'
  post 'payments(/:id)', to: 'payments#notify'
  match '/signin', to: 'sessions#new', via: :get, as: 'signin'
  match '/signout', to: 'sessions#destroy', via: :delete, as: 'signout'
  match 'contests/:contest_id/competitions/:id/rate', to: 'competitions#rate',
    via: :get, as: 'rate_competition'
end
