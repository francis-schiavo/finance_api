# frozen_string_literal: true

require 'test_helper'

module Api
  module V2
    class TransactionsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @transaction = transactions(:one)
        @transaction_data = @transaction.attributes.slice('terminal_id', 'account_id', 'amount', 'timestamp')
      end

      test 'should get index' do
        get api_v2_transactions_url, as: :json

        assert_response :success
      end

      test 'should create transaction' do
        assert_difference('::Transaction.count') do
          post api_v2_transactions_url, params: { transaction: @transaction_data }, as: :json
        end

        assert_response :created
      end

      test 'should not create transaction without terminal_id' do
        assert_no_difference('::Transaction.count') do
          post api_v2_transactions_url, params: { transaction: @transaction_data.except('terminal_id') }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create transaction without account_id' do
        assert_no_difference('::Transaction.count') do
          post api_v2_transactions_url, params: { transaction: @transaction_data.except('account_id') }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create transaction without amount' do
        assert_no_difference('::Transaction.count') do
          post api_v2_transactions_url, params: { transaction: @transaction_data.except('amount') }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create transaction without timestamp' do
        assert_no_difference('::Transaction.count') do
          post api_v2_transactions_url, params: { transaction: @transaction_data.except('timestamp') }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create transaction with negative amount' do
        assert_no_difference('::Transaction.count') do
          post api_v2_transactions_url, params: { transaction: @transaction_data.merge('amount' => -1) }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create transaction with zero amount' do
        assert_no_difference('::Transaction.count') do
          post api_v2_transactions_url, params: { transaction: @transaction_data.merge('amount' => 0) }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should show transaction' do
        get api_v2_transaction_url(@transaction), as: :json

        assert_response :success
      end
    end
  end
end
