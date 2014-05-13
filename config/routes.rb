Rails.application.routes.draw do
  resources :contests do
    resources :competitions, except: [:index]
  end
  resources :payments, except: :destroy
  resources :shooters, except: :destroy
  root 'contests#index'
  get 'names.json', to: 'shooters#names'
end
