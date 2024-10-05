# frozen_string_literal: true

require 'test_helper'

module Api
    class SpecialPagesControllerTest < ActionDispatch::IntegrationTest
      test 'should get healthcheck' do
        get api_healthcheck_url

        assert_response :success
      end
    end
end
