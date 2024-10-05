# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  concern :preflightable do
    collection do
      match '/', action: 'preflight', via: :options
      match '*all', action: 'preflight', via: :options
    end
  end

  namespace :api do
    get '/healthcheck', to: 'special_pages#healthcheck'

    namespace :v1 do
      resources :people, concerns: :preflightable
      resources :accounts, concerns: :preflightable, except: %i[destroy]
      resources :terminals, concerns: :preflightable, except: %i[destroy]
      resources :transactions, concerns: :preflightable, except: %i[update destroy]
    end

    namespace :v2 do
      resources :people, concerns: :preflightable
      resources :accounts, concerns: :preflightable, except: %i[destroy]
      resources :terminals, concerns: :preflightable, except: %i[destroy]
      resources :transactions, concerns: :preflightable, except: %i[update destroy]
    end
  end
end
