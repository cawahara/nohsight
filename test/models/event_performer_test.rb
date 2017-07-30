# frozen_string_literal: true

require 'test_helper'

class EventPerformerTest < ActiveSupport::TestCase
   def setup
      @event_program = event_programs(:event_funabenkei)
      @performer = performers(:shite)
      @event_performer = EventPerformer.new(
         event_program_id: @event_program.id,
         performer_id:     @performer.id
      )
   end

   test 'should be valid' do
      assert @event_performer.valid?
   end

   test 'should be deleted when relative event program destroyed' do
      @event_performer.save
      @event_program.destroy
      assert_equal @event_program.event_performers.count, 0
   end

   test 'should be deleted when relative performer destroyed' do
      @event_performer.save
      @performer.destroy
      assert_equal @performer.event_performers.count, 0
   end

   test 'event_program_id should be present' do
      @event_performer.event_program_id = ''
      assert_not @event_performer.valid?
   end

   test 'performer_id should be present' do
      @event_performer.performer_id = ''
      assert_not @event_performer.valid?
   end
end
