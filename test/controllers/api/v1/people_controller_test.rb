# frozen_string_literal: true

require 'test_helper'

module Api
  module V1
    class PeopleControllerTest < ActionDispatch::IntegrationTest
      setup do
        @person = people(:john)
        @person_data = @person.attributes.slice('name', 'last_name', 'birthday')
      end

      test 'should get index' do
        get api_v1_people_url, as: :json

        assert_response :success
      end

      test 'should create person' do
        assert_difference('Person.count') do
          post api_v1_people_url, params: { person: @person_data }, as: :json
        end

        assert_response :created
      end

      test 'should not create person without name' do
        assert_no_difference('Person.count') do
          post api_v1_people_url, params: { person: @person_data.merge('name' => nil) }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create person without last name' do
        assert_no_difference('Person.count') do
          post api_v1_people_url, params: { person: @person_data.merge('last_name' => nil) }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should not create person without birthday' do
        assert_no_difference('Person.count') do
          post api_v1_people_url, params: { person: @person_data.merge('birthday' => nil) }, as: :json
        end

        assert_response :unprocessable_entity
      end

      test 'should show person' do
        get api_v1_person_url(@person), as: :json

        assert_response :success
      end

      test 'should update person' do
        patch api_v1_person_url(@person), params: { person: @person_data }, as: :json

        assert_response :success
      end

      test 'should not update person without name' do
        patch api_v1_person_url(@person), params: { person: @person_data.merge('name' => nil) }, as: :json

        assert_response :unprocessable_entity
      end

      test 'should not update person without last name' do
        patch api_v1_person_url(@person), params: { person: @person_data.merge('last_name' => nil) }, as: :json

        assert_response :unprocessable_entity
      end

      test 'should not update person without birthday' do
        patch api_v1_person_url(@person), params: { person: @person_data.merge('birthday' => nil) }, as: :json

        assert_response :unprocessable_entity
      end

      test 'should destroy person' do
        assert_difference('Person.count', -1) do
          delete api_v1_person_url(@person), as: :json
        end

        assert_response :no_content
      end
    end
  end
end
