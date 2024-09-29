# frozen_string_literal: true

module Api
  module V1
    # Accounts Controller V1
    class AccountsController < ApplicationController
      before_action :set_account, only: %i[show update]

      # GET /api/v1/accounts
      def index
        @accounts = ::Account.all

        render json: @accounts
      end

      # GET /api/v1/accounts/1
      def show
        render json: @account
      end

      # POST /api/v1/accounts
      def create
        @account = ::Account.new(account_create_params)

        if @account.save
          render json: @account, status: :created, location: api_v1_account_url(@account)
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/accounts/1
      def update
        if @account.update(account_update_params)
          render json: @account
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_account
        @account = ::Account.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def account_create_params
        params.require(:account).permit(:person_id, :balance)
      end

      def account_update_params
        params.require(:account).permit(:balance)
      end
    end
  end
end
