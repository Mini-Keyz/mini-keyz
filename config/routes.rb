Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  authenticated :user do
    resources :simulations, only: %i[index show new create update destroy]
    resources :users, only: [:show]
  end
end
