# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEvent, type: :model do
   describe 'relative associations' do
      it 'belongs to user' do
         assc_user = described_class.reflect_on_association(:user)
         expect(assc_user.macro).to eq(:belongs_to)
      end

      it 'belongs to event' do
         assc_event = described_class.reflect_on_association(:event)
         expect(assc_event.macro).to eq(:belongs_to)
      end
   end

   describe 'validation' do
      let(:usr_ev) { build(:model_user_event) }

      it 'is valid with user_id and event_id' do
         expect(usr_ev).to be_valid
      end

      context 'user_id' do
         it 'is invalid without an user_id' do
            usr_ev.user_id = nil
            usr_ev.valid?
            expect(usr_ev.errors[:user_id]).to include("can't be blank")
         end
      end

      context 'event_id' do
         it 'is invalid without an event_id' do
            usr_ev.event_id = nil
            usr_ev.valid?
            expect(usr_ev.errors[:event_id]).to include("can't be blank")
         end
      end

      context 'oranizer' do
         it 'is invalid with improper value' do
            usr_ev.organizer = nil
            usr_ev.valid?
            expect(usr_ev.errors[:organizer]).to include('is not included in the list')
         end
      end
   end
end
