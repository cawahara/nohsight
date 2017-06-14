require 'test_helper'

class ProgramTest < ActiveSupport::TestCase

   def setup
      @place = places(:gojo)
      @program = Program.new(
                             place_id:   @place.id,
                             title:    "例話",
                             category: "一番目",
                             shimai:   true,
                             duration: 40
                            )
   end

   test "should be valid" do
      assert @program.valid?
   end

   test "should be deleted when relative place destroyed" do
      @program.save
      @place.destroy
      assert_equal @place.programs.count, 0
   end

   test "title should be present" do
      @program.title = ""
      assert_not @program.valid?
   end

end
