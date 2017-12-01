# frozen_string_literal: true

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

      context 'related to events through user_events' do
         let(:user) { create(:model_user, :start_from_this) }
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:events)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated event from user' do
            expect(user.events.first).to eq(user.user_events.first.event)
         end
      end

      context 'related to point_records' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:point_records)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that user has many point_records' do
            expect{ create(:model_user, :start_from_this) }.to change(PointRecord, :count).by(1)
         end
      end

      context 'related to comments' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:comments)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that user has many comments' do
            expect{ create(:model_user, :start_from_this) }.to change(Comment, :count).by(1)
         end
      end

      context 'related to bookmarks' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:bookmarks)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that user has many bookmarks' do
            expect{ create(:model_user, :start_from_this) }.to change(Bookmark, :count).by(1)
         end
      end

      context 'related to events through bookmarks' do
         let(:user) { create(:model_user, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:events)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated event from user' do
            expect(user.bookmark_events.first).to eq(user.bookmarks.first.event)
         end
      end

      context 'related to join_histories' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:join_histories)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that user has many join_histories' do
            expect{ create(:model_user, :start_from_this) }.to change(JoinHistory, :count).by(1)
         end
      end

      context 'related to events through join_histories' do
         let(:user) { create(:model_user, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:events)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated event from user' do
            expect(user.join_events.first).to eq(user.join_histories.first.event)
         end
      end

      context 'destroying dependency' do
         let(:user) { create(:model_user, :start_from_this) }
         let(:another_user) { create(:another_user, :start_from_this) }
         before(:each) do
            user.destroy
         end

         it 'deletes relative point_records' do
            expect(user.point_records.count).to eq(0)
         end

         it "doesn't delete not relative point_records" do
            expect(another_user.point_records.count).not_to eq(0)
         end

         it 'deletes relative comments' do
            expect(user.comments.count).to eq(0)
         end

         it "doesn't delete not relative comments" do
            expect(another_user.comments.count).not_to eq(0)
         end

         it 'deletes relative bookmarks' do
            expect(user.bookmarks.count).to eq(0)
         end

         it "doesn't delete not relative bookmarks" do
            expect(another_user.bookmarks.count).not_to eq(0)
         end

         it 'deletes relative join_histories' do
            expect(user.join_histories.count).to eq(0)
         end

         it "doesn't delete not relative join_histories" do
            expect(another_user.join_histories.count).not_to eq(0)
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

      context 'is_admin' do
         it 'is convert from any words to true value' do
            words = ['a', 12, true]
            words.each do |word|
               user.is_admin = word
               expect(user.is_admin).to eq(true)
            end
         end

         it 'returns false if false is inserted' do
            user.is_admin = false
            expect(user.is_admin).to eq(false)
         end

         it 'is invalid with nil' do
            user.is_admin = nil
            user.valid?
            expect(user.errors[:is_admin]).to include('is not included in the list')
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

      context 'default on is_admin' do
         it 'returns false' do
            expect(user.is_admin).to eq(false)
         end
      end
   end
end
