Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :simulations, only: %i[show create]

  authenticated :user do
    resources :users, only: [:show]
    resources :simulations, only: %i[index show create update destroy]
  end
end
