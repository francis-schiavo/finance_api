# frozen_string_literal: true

module Api
  module V1
    # Transactions controller V1
    class TransactionsController < ApplicationController
      before_action :set_transaction, only: %i[show]
      before_action :create_transaction_service, only: %i[create]

      # GET /api/v1/transactions
      def index
        @transactions = ::Transaction.all

        render json: @transactions
      end

      # GET /api/v1/transactions/1
      def show
        render json: @transaction
      end

      # POST /api/v1/transactions
      def create
        @transaction = @transaction_service.create using_cache: false

        if @transaction.persisted?
          render json: @transaction, status: :created, location: api_v1_transaction_url(@transaction)
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_transaction
        @transaction = ::Transaction.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def transaction_params
        params.require(:transaction).permit(:terminal_id, :account_id, :amount, :timestamp)
      end

      def create_transaction_service
        @transaction_service = TransactionService.new(transaction_params, request_id: request.uuid)
      end
    end
  end
end
