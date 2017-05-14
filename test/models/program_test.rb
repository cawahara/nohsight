require 'test_helper'

class ProgramTest < ActiveSupport::TestCase

   def setup
      @program = Program.new(
                             title:    "例話",
                             category: "一番目",
                             location: "例得寺",
                             shimai:   true,
                             duration: 40
                            )
   end

   test "should be valid" do
      assert @program.valid?
   end

   test "title should be present" do
      @program.title = ""
      assert_not @program.valid?
   end

   test "category should be present" do
      @program.category = ""
      assert_not @program.valid?
   end

   test "location should be present" do
      @program.location = ""
      assert_not @program.valid?
   end

   test "duration should be present" do
      @program.duration = ""
      assert_not @program.valid?
   end

end
