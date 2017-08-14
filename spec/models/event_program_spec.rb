# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventProgram, type: :model do
   describe '#association' do
      context 'related to event' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:event)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that event_program belongs to event' do
            event_program = create(:model_event_program)
            expect(event_program.event).to be_truthy
         end
      end

      context 'related to program' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:program)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that event_program belongs to program' do
            event_program = create(:model_event_program)
            expect(event_program.program).to be_truthy
         end
      end

      context 'related to event_performers' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:event_performers)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event_program has many event_performers' do
            expect{ create(:model_event_program, :start_from_this) }.to change(EventPerformer, :count).by(1)
         end
      end

      context 'related to performers through event_performers' do
         let(:event_program) { create(:model_event_program, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:performers)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated performer from event_program' do
            expect(event_program.performers.first).to eq(event_program.event_performers.first.performer)
         end
      end

      context 'destroying dependency' do
         let(:event_program) { create(:model_event_program, :start_from_this) }
         let(:another_event_program) { create(:another_event_program, :start_from_this) }
         before(:each) do
            event_program.destroy
         end

         it "doesn't delete relative event" do
            expect(event_program.event).to be_truthy
         end

         it "doesn't delete relative program" do
            expect(event_program.program).to be_truthy
         end

         it 'deletes relative event_performers' do
            expect(event_program.event_performers.count).to eq(0)
         end

         it "doesn't delete not relative event_performers" do
            expect(another_event_program.event_performers.count).not_to eq(0)
         end
      end
   end

   describe '#validation' do
      let(:ev_program) { build(:model_event_program) }

      it 'is valid with program_id, event_id, style, and genre' do
         expect(ev_program).to be_valid
      end

      context 'program_id' do
         it 'is invalid with empty program_id' do
            ev_program.program_id = nil
            ev_program.valid?
            expect(ev_program.errors[:program_id]).to include("can't be blank")
         end
      end

      context 'event_id' do
         it 'is invalid with empty event_id' do
            ev_program.event_id = nil
            ev_program.valid?
            expect(ev_program.errors[:event_id]).to include("can't be blank")
         end
      end

      context 'style' do
         it 'is invalid with empty style' do
            ev_program.style = nil
            ev_program.valid?
            expect(ev_program.errors[:style]).to include("can't be blank")
         end
      end

      context 'genre' do
         it 'is invalid with empty genre' do
            ev_program.genre = nil
            ev_program.valid?
            expect(ev_program.errors[:genre]).to include("can't be blank")
         end
      end
   end

   context '#method' do
      it 'returns required columns' do
         expect(EventProgram.required_columns).to eq(['event_id', 'program_id', 'genre', 'style'])
      end
   end
end
