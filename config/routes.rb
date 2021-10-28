Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
  get 'accept_cookies', to: 'pages#accept_cookies', as: 'accept_cookies'
  get 'refuse_cookies', to: 'pages#refuse_cookies', as: 'refuse_cookies'
  get 'cookies_policy', to: 'pages#cookies_policy', as: 'cookies_policy'
  get 'change_locale', to: 'pages#change_locale', as: 'change_locale'

  get '/simulations/:id/send_simulation_mail', to: 'simulations#send_simulation_mail', as: :send_simulation_mail

  constraints subdomain: ['www', '', 'mini-keyz-staging'] do
    authenticated :user do
      resources :simulations
      resources :users, only: [:show]
    end

    resources :simulations, only: %i[show new create]
    resources :build_simulation, only: %i[update show], controller: 'steps_controllers/simulation_steps'
  end
end
