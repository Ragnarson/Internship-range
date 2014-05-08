Rails.application.routes.draw do
  resources :contests

  root 'contests#index'
end
