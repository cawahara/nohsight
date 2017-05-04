require 'test_helper'

class EventTest < ActiveSupport::TestCase

   def setup
      @user = users(:pupil)
      @event = Event.new(
                         user_id: @user.id,
                         place_id: 1,         # 仮番号
                         title: "例えて習おう能楽の世界",
                         start_date: Date.today
                        )
   end

   test "should be valid" do
      assert @event.valid?
   end

   test "should be deleted when relative user destroyed" do
      @event.save
      assert_difference 'Event.count', -1 do
         @user.destroy
      end
   end

   test "user_id should be present" do
      @event.user_id = ""
      assert_not @event.valid?
   end

   test "title should be present" do
      @event.title = ""
      assert_not @event.valid?
   end

   test "start_date should be present" do
      @event.start_date = ""
      assert_not @event.valid?
   end

end
