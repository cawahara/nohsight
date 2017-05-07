require 'test_helper'

class PlaceTest < ActiveSupport::TestCase

   def setup
      @place = Place.new(
                         address:            "京都府京都市西京区54321番地",
                         official_site_url:  "one-place.com"
                        )
   end

   test "should be valid" do
      assert @place.valid?
   end

   test "address should be present" do
      @place.address = ""
      assert_not @place.valid?
   end
end
