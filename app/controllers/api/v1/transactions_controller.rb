# frozen_string_literal: true

module Api
  module V1
    # Transactions controller V1
    class TransactionsController < ApplicationController
      before_action :set_transaction, only: %i[show]

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
        @transaction = ::Transaction.new(transaction_params)

        if @transaction.save
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
    end
  end
end
