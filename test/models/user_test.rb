# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
   def setup
      @user = User.new(
         name:                   '例学　雅人',
         email:                  'example@gmail.com',
         password:               'password',
         password_confirmation:  'password',
         agreement:              true
      )
   end

   test 'should be valid' do
      assert @user.valid?
   end

   test 'name should be present' do
      @user.name = ''
      assert_not @user.valid?
   end

   test 'email should be present' do
      @user.email = ''
      assert_not @user.valid?
   end

   test 'email should be in a proper format' do
      valid_addresses = [
         'user@example.com',
         'user@mail.co.jp',
         'USER@foo.com',
         'foo_bar+oh@mail.com'
      ]
      valid_addresses.each do |address|
         @user.email = address
         assert @user.valid?
      end
   end

   test 'password should be present' do
      @user.password = ''
      @user.password_confirmation = ''
      assert_not @user.valid?
   end

   test 'password should match with its confirmation' do
      @user.password = 'drowssap'
      assert_not @user.valid?
      @user.password_confirmation = @user.password
      assert @user.valid?
   end

   test 'password should have more than 4 chars' do
      @user.password = @user.password_confirmation = 'p' * 4
      assert @user.valid?
      @user.password = @user.password_confirmation = 'p' * 3
      assert_not @user.valid?
   end

   test 'should agree when creating a new user' do
      @user.agreement = false
      assert_not @user.valid?
   end
end
