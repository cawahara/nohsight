require 'test_helper'

class PerformerTest < ActiveSupport::TestCase

   def setup
      @performer = Performer.new(
                                 full_name:  "例得　常夏",
                                 last_name:  "たとえ",
                                 first_name: "とこなつ",
                                 style:      "シテ方観世流"
                                )
   end

   test "should be valid" do
      assert @performer.valid?
   end

   test "full_name should be present" do
      @performer.full_name = ""
      assert_not @performer.valid?
   end

   test "last_name should be present" do
      @performer.last_name = ""
      assert_not @performer.valid?
   end

   test "last_name should be ひらがな" do
      not_hiraganas = [
                       "例え",
                       "タトエ",
                       "た都得",
                       "tatoe"
                      ]
      not_hiraganas.each do |moji|
         @performer.last_name = moji
         assert_not @performer.valid?
      end
   end

   test "first_name should be present" do
      @performer.first_name = ""
      assert_not @performer.valid?
   end

   test "first_name should be ひらがな" do
      not_hiraganas = [
                       "例え",
                       "タトエ",
                       "た都得",
                       "tatoe"
                      ]
      not_hiraganas.each do |moji|
         @performer.last_name = moji
         assert_not @performer.valid?
      end
   end

   test "class should be present" do
      @performer.style = ""
      assert_not @performer.valid?
   end
end
