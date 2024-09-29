# frozen_string_literal: true

module Api
  module V2
    # People controller V2
    class PeopleController < ApplicationController
      before_action :set_person, only: %i[show update destroy]

      # GET /api/v2/people
      def index
        @people = Person.all

        render json: @people
      end

      # GET /api/v2/people/1
      def show
        render json: @person
      end

      # POST /api/v2/people
      def create
        @person = Person.new(person_params)

        if @person.save
          render json: @person, status: :created, location: api_v2_person_url(@person)
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v2/people/1
      def update
        if @person.update(person_params)
          render json: @person
        else
          render json: @person.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v2/people/1
      def destroy
        @person.destroy!
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_person
        @person = Person.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def person_params
        params.require(:person).permit(:name, :last_name, :birthday)
      end
    end
  end
end
