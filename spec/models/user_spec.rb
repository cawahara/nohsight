# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
   describe 'relative assocations' do
      it 'has many user_events' do
         assc_usr_ev = described_class.reflect_on_association(:user_events)
         expect(assc_usr_ev.macro).to eq(:has_many)
      end
   end

   describe 'assocation dependency for destroy' do
      let(:user) { build(:model_user) }
      let(:place)  { build(:model_place) }
      let(:event)  { build(:model_event) }
      let(:usr_ev) { build(:model_user_event) }

      it 'destroys associated events' do
         user.destroy
         expect(Event.where(id: event.id)).to be_empty
      end

      it 'destroys associated user_events' do
         user.destroy
         expect(UserEvent.where(id: usr_ev.id)).to be_empty
      end
   end

   describe 'validation' do
      let(:user) { build(:model_user) }

      it 'is valid with name, email, information, and password' do
         expect(user).to be_valid
      end

      describe 'name' do
         it 'is invalid without a name' do
            user.name = nil
            # REVIEW: なぜexpectメソッドの前にuser.validでuserがUserとして有効か
            # =>      検証する必要があるのか
            user.valid?
            expect(user.errors[:name]).to include("can't be blank")
         end
      end

      describe 'email' do
         it 'is invalid without an email' do
            user.email = nil
            user.valid?
            expect(user.errors[:email]).to include("can't be blank")
         end

         it 'is invalid with an improper email' do
            invalid_emails = ['user@example,com',
                              'gabriel_yahoo_co_jp',
                              'mon_key@+oh@foo.com']
            invalid_emails.each do |invalid_email|
               user.email = invalid_email
               user.valid?
               expect(user.errors[:email]).to include('is invalid')
            end
         end

         it 'is invalid with a duplicate email address' do
            user.save
            dup_user = user.dup
            dup_user.valid?
            expect(dup_user.errors[:email]).to include('has already been taken')
         end
      end

      describe 'password' do
         it 'is invalid without a password' do
            user.password = nil
            user.valid?
            expect(user.errors[:password]).to include("can't be blank")
         end

         it "isn't accepted authentication of password confirmation" do
            user.password = 'password'
            user.password_confirmation = 'drowssap'
            user.valid?
            expect(user.errors[:password_confirmation]).to include("doesn't match Password")
         end

         it 'is invalid with a less than 4 character-password' do
            user.password = 'pas'
            user.password_confirmation = 'pas'
            user.valid?
            expect(user.errors[:password]).to include('is too short (minimum is 4 characters)')
         end
      end
   end
end
