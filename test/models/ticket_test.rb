# frozen_string_literal: true

require 'test_helper'

class TicketTest < ActiveSupport::TestCase
   def setup
      @event = events(:spring)
      @ticket = Ticket.new(
         event_id: @event.id,
         grade:    '特等席',
         price:    14_000
      )
   end

   test 'should be valid' do
      assert @ticket.valid?
   end

   test 'should be deleted when relative place destroyed' do
      @ticket.save
      @event.destroy
      assert_equal @event.tickets.count, 0
   end

   test 'event_id should be present' do
      @ticket.event_id = ''
      assert_not @ticket.valid?
   end

   test 'grade should be present' do
      @ticket.grade = ''
      assert_not @ticket.valid?
   end

   test 'price should be present' do
      @ticket.price = ''
      assert_not @ticket.valid?
   end
end
