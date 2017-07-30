# frozen_string_literal: true

require 'test_helper'

class EventProgramsControllerTest < ActionDispatch::IntegrationTest
   test 'should get edit' do
      get event_programs_edit_url
      assert_response :success
   end

   test 'should get create' do
      get event_programs_create_url
      assert_response :success
   end

   test 'should get update' do
      get event_programs_update_url
      assert_response :success
   end

   test 'should get destroy' do
      get event_programs_destroy_url
      assert_response :success
   end
end
