# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
   describe 'relative associations' do
      it 'belongs to user' do
         assc_user = described_class.reflect_on_association(:user)
         expect(assc_user.macro).to eq(:belongs_to)
      end

      it 'belongs to place' do
         assc_place = described_class.reflect_on_association(:place)
         expect(assc_place.macro).to eq(:belongs_to)
      end

      it 'has many event_programs' do
         assc_ev_pro = described_class.reflect_on_association(:event_programs)
         expect(assc_ev_pro.macro).to eq(:has_many)
      end

      it 'has many tickets' do
         assc_ticket = described_class.reflect_on_association(:tickets)
         expect(assc_ticket.macro).to eq(:has_many)
      end

      it 'has many user_events' do
         assc_usr_ev = described_class.reflect_on_association(:user_events)
         expect(assc_usr_ev.macro).to eq(:has_many)
      end
   end

   describe 'assocation dependency for destroy' do
      let(:event) { build(:model_event) }
      let(:ev_pro)  { build(:model_event_program) }
      let(:ticket)  { build(:model_ticket) }
      let(:usr_ev)  { build(:model_user_event) }

      it 'destroys associated event_programs' do
         event.destroy
         expect(EventProgram.where(id: ev_pro.id)).to be_empty
      end

      it 'destroys associated tickets' do
         event.destroy
         expect(Ticket.where(id: ticket.id)).to be_empty
      end

      it 'destroys associated user_events' do
         event.destroy
         expect(UserEvent.where(id: usr_ev.id)).to be_empty
      end
   end

   describe 'validation' do
      let(:event) { build(:model_event) }

      it 'is valid with title, start_date, end_date, information, official_url, place_id, and user_id' do
         expect(event).to be_valid
      end

      describe 'title' do
         it 'is invalid without a title' do
            event.title = nil
            event.valid?
            expect(event.errors[:title]).to include("can't be blank")
         end
      end

      describe 'user_id' do
         it 'is invalid without a user_id' do
            event.user_id = nil
            event.valid?
            expect(event.errors[:user_id]).to include("can't be blank")
         end
      end

      describe 'published' do
         it 'is invalid with improper value in published field' do
            event.published = nil
            event.valid?
            expect(event.errors[:published]).to include('is not included in the list')
         end
      end
   end
end
