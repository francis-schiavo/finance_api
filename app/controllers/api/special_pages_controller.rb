# frozen_string_literal: true

module Api
  # Special or static pages
  class SpecialPagesController < ApplicationController
    def healthcheck
      render json: { status: 'ok' }
    end
  end
end
