require 'test_helper'

class UserEventTest < ActiveSupport::TestCase
  def setup
     @user = users(:pupil)
     @event = events(:spring)
     @user_event = UserEvent.new(
                                 user_id: @user.id,
                                 event_id: @event.id
                                )
  end

  test "should be valid" do
     assert @user_event.valid?
  end

  test "should be deleted when relative user destroyed" do
     @user_event.save
     @user.destroy
     assert_equal @user.user_events.count, 0
  end

  test "should be deleted when relative event destroyed" do
     @user_event.save
     @event.destroy
     assert_equal @event.user_events.count, 0
  end

  test "user_id should be present" do
     @user_event.user_id = ""
     assert_not @user_event.valid?
  end

  test "event_id should be present" do
     @user_event.event_id = ""
     assert_not @user_event.valid?
  end
end
