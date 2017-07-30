# frozen_string_literal: true

require 'test_helper'

class PerformerTest < ActiveSupport::TestCase
   def setup
      @style     = styles(:shite_kongou)
      @performer = Performer.new(
         full_name:  '例得　常夏',
         last_name:  'たとえ',
         first_name: 'とこなつ',
         style_id:   @style.id
      )
   end

   test 'should be valid' do
      assert @performer.valid?
   end

   test 'should be deleted when relative style destroyed' do
      @performer.save
      @style.destroy
      assert_equal @style.performers.count, 0
   end

   test 'full_name should be present' do
      @performer.full_name = ''
      assert_not @performer.valid?
   end

   test 'last_name should be ひらがな' do
      not_hiraganas = [
         '例え',
         'タトエ',
         'た都得',
         'tatoe'
      ]
      not_hiraganas.each do |moji|
         @performer.last_name = moji
         assert_not @performer.valid?
      end
   end

   test 'first_name should be ひらがな' do
      not_hiraganas = [
         '例え',
         'タトエ',
         'た都得',
         'tatoe'
      ]
      not_hiraganas.each do |moji|
         @performer.last_name = moji
         assert_not @performer.valid?
      end
   end
end
