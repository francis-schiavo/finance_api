# frozen_string_literal: true

module Api
  module V1
    # Special or static pages
    class SpecialPagesController < ApplicationController
      def healthcheck; end
    end
  end
end
