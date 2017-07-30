# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventProgram, type: :model do
   describe 'relative associations' do
      it 'belongs to event' do
         assc_event = described_class.reflect_on_association(:event)
         expect(assc_event.macro).to eq(:belongs_to)
      end

      it 'belongs to program' do
         assc_program = described_class.reflect_on_association(:program)
         expect(assc_program.macro).to eq(:belongs_to)
      end

      it 'has many event_performers' do
         assc_ev_per = described_class.reflect_on_association(:event_performers)
         expect(assc_ev_per.macro).to eq(:has_many)
      end
   end

   describe 'assocation dependency for destroy' do
      let!(:style) { create(:model_style) }
      let(:ev_pro) { build(:model_event_program) }
      let(:ev_per) { build(:model_event_performer) }

      it 'destroys associated event_performers' do
         ev_pro.destroy
         expect(EventPerformer.where(id: ev_per.id)).to be_empty
      end
   end

   describe 'validation' do
      let(:ev_pro) { build(:model_event_program) }

      it 'is valid with user_id and event_id' do
         expect(ev_pro).to be_valid
      end

      describe 'program_id' do
         it 'is invalid without an program_id' do
            ev_pro.program_id = nil
            ev_pro.valid?
            expect(ev_pro.errors[:program_id]).to include("can't be blank")
         end
      end

      describe 'event_id' do
         it 'is invalid without an event_id' do
            ev_pro.event_id = nil
            ev_pro.valid?
            expect(ev_pro.errors[:event_id]).to include("can't be blank")
         end
      end

      describe 'style' do
         it 'is invalid without an style' do
            ev_pro.style = nil
            ev_pro.valid?
            expect(ev_pro.errors[:style]).to include("can't be blank")
         end
      end

      describe 'genre' do
         it 'is invalid without an genre' do
            ev_pro.genre = nil
            ev_pro.valid?
            expect(ev_pro.errors[:genre]).to include("can't be blank")
         end
      end
   end
end
