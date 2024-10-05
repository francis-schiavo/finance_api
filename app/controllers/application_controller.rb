# frozen_string_literal: true

# Base controller
class ApplicationController < ActionController::API
  before_action :preflight_defaults

  def preflight
    response.headers['Access-Control-Allow-Methods'] = allowed_methods.join(', ')
    head :ok
  end

  private

  def preflight_defaults
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end

  def allowed_methods
    defined_methods = public_methods

    http_methods = %w[GET OPTIONS]
    http_methods.push('POST') if defined_methods.include?(:create)
    http_methods.push('PATCH') if defined_methods.include?(:update)
    http_methods.push('DELETE') if defined_methods.include?(:destroy)

    http_methods
  end
end
