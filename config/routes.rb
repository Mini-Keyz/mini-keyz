Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'

  constraints subdomain: 'api' do
    get 'about', to: 'pages#about'
    get 'contact', to: 'pages#contact'
  end

  constraints subdomain: ['www', '', 'mini-keyz-staging'] do
    authenticated :user do
      resources :simulations, only: %i[index show new create update destroy]
      get '/simulations/:id/send_simulation_mail', to: 'simulations#send_simulation_mail', as: :send_simulation_mail
      resources :users, only: [:show]
    end

    resources :simulations, only: %i[show new create]
  end
end
