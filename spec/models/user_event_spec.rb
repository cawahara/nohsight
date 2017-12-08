# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEvent, type: :model do
   describe '#association' do
      context 'related to user' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:user)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that user_event belongs to user' do
            user_event = create(:model_user_event)
            expect(user_event.user).to be_truthy
         end
      end

      context 'related to event' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:event)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that user_event belongs to event' do
            user_event = create(:model_user_event)
            expect(user_event.event).to be_truthy
         end
      end

      context 'destroying dependency' do
         let(:user_event) { create(:model_user_event) }
         before(:each) do
            user_event.destroy
         end

         it "doesn't delete relative user" do
            expect(user_event.user).to be_truthy
         end

         it "doesn't delete relative event" do
            expect(user_event.event).to be_truthy
         end
      end
   end

   describe '#validation' do
      let (:user_event) { build(:model_user_event) }

      it 'is valid with user_id, event_id, and organizer' do
         expect(user_event).to be_valid
      end

      context 'user_id' do
         it 'is invalid with empty user_id' do
            user_event.user_id = nil
            user_event.valid?
            expect(user_event.errors[:user_id]).to include("can't be blank")
         end
      end

      context 'event_id' do
         it 'is invalid with empty event_id' do
            user_event.event_id = nil
            user_event.valid?
            expect(user_event.errors[:event_id]).to include("can't be blank")
         end
      end

      context 'organizer' do
         it 'is convert from any words to true value' do
            words = ['a', 12, true]
            words.each do |word|
               user_event.organizer = word
               expect(user_event.organizer).to eq(true)
            end
         end

         it 'returns false if false is inserted' do
            user_event.organizer = false
            expect(user_event.organizer).to eq(false)
         end

         it 'is invalid with nil' do
            user_event.organizer = nil
            user_event.valid?
            expect(user_event.errors[:organizer]).to include('is not included in the list')
         end
      end
   end
end
