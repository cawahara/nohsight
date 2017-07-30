# frozen_string_literal: true

require 'test_helper'

class StyleTest < ActiveSupport::TestCase
   def setup
      @style = Style.new(title: 'ワキ方高安流')
   end

   test 'should be valid' do
      assert @style.valid?
   end

   test 'title should be present' do
      @style.title = ''
      assert_not @style.valid?
   end
end
