require 'test_helper'

class EventProgramTest < ActiveSupport::TestCase

   def setup
      @event = events(:spring)
      @program = programs(:funabenkei)
      @event_program = EventProgram.new(
                                        event_id:    @event.id,
                                        program_id:  @program.id,
                                        style:       "金剛流",
                                        genre:       "能"
                                       )
   end

   test "should be valid" do
      assert @event_program.valid?
   end

   test "should be deleted when relative event destroyed" do
      @event_program.save
      @event.destroy
      assert_equal @event.event_programs.count, 0
   end

   test "should be deleted when relative program destroyed" do
      @event_program.save
      @program.destroy
      assert_equal @program.event_programs.count, 0
   end

   test "event_id should be present" do
      @event_program.event_id = ""
      assert_not @event_program.valid?
   end

   test "program_id should be present" do
      @event_program.program_id = ""
      assert_not @event_program.valid?
   end

   test "style should be present" do
      @event_program.style = ""
      assert_not @event_program.valid?
   end

   test "genre should be present" do
      @event_program.genre = ""
      assert_not @event_program.valid?
   end
end
