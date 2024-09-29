# frozen_string_literal: true

require 'test_helper'

module Api
  module V2
    class AccountsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @account = accounts(:account_one)
        @account_data = @account.attributes.slice('person_id', 'balance')
      end

      test 'should get index' do
        get api_v2_accounts_url, as: :json

        assert_response :success
      end

      test 'should create account' do
        assert_difference('::Account.count') do
          post api_v2_accounts_url, params: { account: @account_data }, as: :json
        end

        assert_response :created
      end

      test 'should not create account without a person' do
        assert_no_difference('::Account.count') do
          post api_v2_accounts_url, params: { account: @account_data.except('person_id') }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create account without a balance' do
        assert_no_difference('::Account.count') do
          post api_v2_accounts_url, params: { account: @account_data.except('balance') }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should show api_v2_account' do
        get api_v2_account_url(@account), as: :json

        assert_response :success
      end

      test 'should update api_v2_account' do
        patch api_v2_account_url(@account), params: { account: @account_data }, as: :json

        assert_response :success
      end
    end
  end
end
