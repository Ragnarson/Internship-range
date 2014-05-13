Rails.application.routes.draw do
  resources :contests do
    resources :competitions, except: [:index]
  end
  resources :payments, except: :destroy
  resources :shooters, only: [:index]
  root 'contests#index'
  get 'names.json', to: 'shooters#names'
end
