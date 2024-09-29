# frozen_string_literal: true

require 'test_helper'

module Api
  module V2
    class TerminalsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @terminal = terminals(:one)
      end

      test 'should get index' do
        get api_v2_terminals_url, as: :json

        assert_response :success
      end

      test 'should create terminal' do
        assert_difference('::Terminal.count') do
          post api_v2_terminals_url, params: { terminal: { alias: 'Terminal three' } }, as: :json
        end

        assert_response :created
      end

      test 'should show terminal' do
        get api_v2_terminal_url(@terminal), as: :json

        assert_response :success
      end

      test 'should update terminal' do
        patch api_v2_terminal_url(@terminal), params: { terminal: { alias: 'Terminal 2' } }, as: :json

        assert_response :success
      end
    end
  end
end
