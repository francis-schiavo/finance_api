# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api do
    namespace :v1 do
      get '/healthcheck', to: 'special_pages#healthcheck'

      resources :people
    end
  end
end
