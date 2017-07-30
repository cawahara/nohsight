# frozen_string_literal: true

require 'test_helper'

class EventTest < ActiveSupport::TestCase
   def setup
      @user = users(:pupil)
      @place = places(:kongo)
      @event = Event.new(
         user_id:    @user.id,
         place_id:   @place.id,
         title:      '例えて習おう能楽の世界',
         start_date: Date.today,
         published:  true
      )
   end

   test 'should be valid' do
      assert @event.valid?
   end

   test 'should be deleted when relative user destroyed' do
      @event.save
      @user.destroy
      assert_equal @user.events.count, 0
   end

   test 'should be deleted when relative place destroyed' do
      @event.save
      @place.destroy
      assert_equal @place.events.count, 0
   end

   test 'user_id should be present' do
      @event.user_id = ''
      assert_not @event.valid?
   end

   test 'title should be present' do
      @event.title = ''
      assert_not @event.valid?
   end

   test 'published should be boolean' do
      @event.published = false
      assert @event.valid?
      @event.published = ''
      assert_not @event.valid?
   end
end
