# frozen_string_literal: true

module Api
  module V2
    # Terminals controller v2
    class TerminalsController < ApplicationController
      before_action :set_terminal, only: %i[show update]

      # GET /api/v2/terminals
      def index
        @terminals = ::Terminal.all

        render json: @terminals
      end

      # GET /api/v2/terminals/1
      def show
        render json: @terminal
      end

      # POST /api/v2/terminals
      def create
        @terminal = ::Terminal.new(terminal_params)

        if @terminal.save
          render json: @terminal, status: :created, location: api_v2_terminal_url(@terminal)
        else
          render json: @terminal.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v2/terminals/1
      def update
        if @terminal.update(terminal_params)
          render json: @terminal
        else
          render json: @terminal.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_terminal
        @terminal = ::Terminal.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def terminal_params
        params.require(:terminal).permit(:number, :alias)
      end
    end
  end
end
