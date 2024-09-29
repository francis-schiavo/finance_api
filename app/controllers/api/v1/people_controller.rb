# frozen_string_literal: true

module Api
  module V1
    # People controller
    class PeopleController < ApplicationController
      before_action :set_api_v1_person, only: %i[show update destroy]

      # GET /api/v1/people
      def index
        @people = ::Person.all

        render json: @people
      end

      # GET /api/v1/people/1
      def show
        render json: @person
      end

      # POST /api/v1/people
      def create
        @person = ::Person.new(api_v1_person_params)

        if @person.save
          render json: @person, status: :created, location: api_v1_person_url(@person)
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/people/1
      def update
        if @person.update(api_v1_person_params)
          render json: @person
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/people/1
      def destroy
        @person.destroy!
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_api_v1_person
        @person = ::Person.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def api_v1_person_params
        params.require(:person).permit(:name, :last_name, :birthday)
      end
    end
  end
end
