# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :accounts
      get '/healthcheck', to: 'special_pages#healthcheck'

      resources :people
    end

    namespace :v2 do
      resources :people
      resources :accounts
    end
  end
end
