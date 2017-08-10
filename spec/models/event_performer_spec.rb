# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventPerformer, type: :model do
   describe '#association' do
      context 'related to event_program' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:event_program)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that event_performer belongs to event_program' do
            event_performer = create(:model_event_performer)
            expect(event_performer.event_program).to be_truthy
         end
      end

      context 'related to performer' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:performer)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that event_performer belongs to performer' do
            event_performer = create(:model_event_performer)
            expect(event_performer.performer).to be_truthy
         end
      end

      context 'destroying dependency' do
         let(:event_performer) { create(:model_event_performer) }
         before(:each) do
            event_performer.destroy
         end

         it "doesn't delete relative event_program" do
            expect(event_performer.event_program).to be_truthy
         end

         it "doesn't delete relative performer" do
            expect(event_performer.performer).to be_truthy
         end
      end
   end

   describe '#validation' do
      let(:ev_performer) { build(:model_event_performer) }

      it 'is valid with event_program_id and performer_id' do
         expect(ev_performer).to be_valid
      end

      context 'event_program_id' do
         it 'is invalid with empty event_program_id' do
            ev_performer.event_program_id = nil
            ev_performer.valid?
            expect(ev_performer.errors[:event_program_id]).to include("can't be blank")
         end
      end

      context 'performer_id' do
         it 'is invalid with empty performer_id' do
            ev_performer.performer_id = nil
            ev_performer.valid?
            expect(ev_performer.errors[:performer_id]).to include("can't be blank")
         end
      end
   end

   describe '#method' do
      it 'returns required columns' do
         expect(EventPerformer.required_columns).to eq(['event_program_id', 'performer_id'])
      end
   end
end
