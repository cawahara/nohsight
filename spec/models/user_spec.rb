# frozen_string_literal: true

# TODO: shared example使ってみる

require 'rails_helper'

RSpec.describe User, type: :model do
   describe '#association' do
      context 'related to user_events' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:user_events)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that user has many user_events' do
            # FIXME; 1をuser.user_eventx.countにしたい(createしたuserを変数に格納したい)
            expect{ create(:model_user, :start_from_this) }.to change(UserEvent, :count).by(1)
         end
      end

      context 'destroying dependency' do
         let(:user) { create(:model_user, :start_from_this) }
         let(:another_user) { create(:another_user, :start_from_this) }
         before(:each) do
            user.destroy
         end

         it 'deletes relative user_events' do
            expect(user.user_events.count).to eq(0)
         end

         it "doesn't delete not relative user_events" do
            expect(another_user.user_events.count).not_to eq(0)
         end
      end
   end

   describe '#validation' do
      let(:user) { build(:model_user) }

      it 'is valid with name, email, and password' do
         expect(user).to be_valid
      end

      context 'name' do
         it 'is invalid with empty name' do
            user.name = nil
            user.valid?
            expect(user.errors[:name]).to include("can't be blank")
         end
      end

      context 'email' do
         it 'is invalid with empty email' do
            user.email = nil
            user.valid?
            expect(user.errors[:email]).to include("can't be blank")
         end

         it 'is invalid with improper formatted email' do
            invalid_emails = ['user@example,com',
                              'user_yahoo_co_jp',
                              'user@name.example.',
                              'mon_key+pa@tch+.com']
            invalid_emails.each do |invalid_email|
               user.email = invalid_email
               user.valid?
               expect(user.errors[:email]).to include('is invalid')
            end
         end

         it 'is unable to save user with submitted email' do
            user.save
            dup_user = user.dup
            dup_user.valid?
            expect(dup_user.errors[:email]).to include('has already been taken')
         end

         it 'is unable to save user with submitted email in upper_case' do
            user.save
            dup_user = user.dup
            dup_user.email.upcase!
            dup_user.valid?
            expect(dup_user.errors[:email]).to include('has already been taken')
         end
      end

      context 'password' do
         it 'is invalid with empty password' do
            user.password = nil
            user.valid?
            expect(user.errors[:password]).to include("can't be blank")
         end

         it 'is invalid with less than 4 character password' do
            user.password = 'a' * 3
            user.valid?
            expect(user.errors[:password]).to include('is too short (minimum is 4 characters)')
         end

         it 'is unable to submit with different password_confirmation param' do
            user.password_confirmation = 'drowssap'
            user.valid?
            expect(user.errors[:password_confirmation]).to include("doesn't match Password")
         end
      end

      context 'agreement' do
         before(:each) do
            user.destroy
         end
         let(:re_user) { build(:model_user) }

         it 'is saved with agreement' do
            re_user.agreement = true
            expect{re_user.save}.to change(User, :count).by(1)
         end

         it 'is unable to be saved without agreement' do
            re_user.agreement = false
            expect{re_user.save}.to change(User, :count).by(0)
         end

         it 'allows nil when update' do
            re_user.save
            re_user.agreement = nil
            expect(re_user).to be_valid
         end
      end
   end

   describe '#method' do
      let(:user) { build(:model_user) }
      context 'self.digest' do
         it 'returns hashed password digest' do
            expect(User.digest(user.password)).not_to be_empty
         end
      end
   end
end
