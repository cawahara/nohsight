# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Program, type: :model do
   describe '#association' do
      context 'related to event_programs' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:event_programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that program has many event_programs' do
            expect{ create(:model_program, :start_from_this) }.to change(EventProgram, :count).by(1)
         end
      end

      context 'related to events through event_programs' do
         let(:program) { create(:model_program, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:events)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated event from program' do
            expect(program.events.first).to eq(program.event_programs.first.event)
         end
      end

      context 'destroying dependency' do
         let(:program) { create(:model_program, :start_from_this) }
         let(:another_program) { create(:another_program, :start_from_this) }
         before(:each) do
            program.destroy
         end

         it 'deletes relative event_programs' do
            expect(program.event_programs.count).to eq(0)
         end

         it "doesn't delete not relative event_programs" do
            expect(another_program.event_programs.count).not_to eq(0)
         end
      end
   end

   describe '#validation' do
      let(:program) { build(:model_program) }

      it 'is valid with title, category, shimai, and duration' do
         expect(program).to be_valid
      end

      context 'title' do
         it 'is invalid with empty title' do
            program.title = nil
            program.valid?
            expect(program.errors[:title]).to include("can't be blank")
         end
      end
   end
end
