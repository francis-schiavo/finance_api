# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    get '/healthcheck', to: 'special_pages#healthcheck', namespace: 'api'

    namespace :v1 do
      resources :people
      resources :accounts, except: %i[destroy]
      resources :terminals, except: %i[destroy]
      resources :transactions, except: %i[update destroy]
    end

    namespace :v2 do
      resources :people
      resources :accounts, except: %i[destroy]
      resources :terminals, except: %i[destroy]
      resources :transactions, except: %i[update destroy]
    end
  end
end
