Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  constraints subdomain: 'api' do
    get 'about', to: 'pages#about'
  end
  get 'contact', to: 'pages#contact'

  authenticated :user do
    resources :simulations, only: %i[index show new create update destroy]
    resources :users, only: [:show]
  end

  resources :simulations, only: %i[show new create]
end
