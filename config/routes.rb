Rails.application.routes.draw do
  resources :contests do
    resources :competitions, except: [:index]
  end

  resources :payments, only: [:index, :show]
  resources :shooters, only: [:index]
  root 'contests#index'
end
