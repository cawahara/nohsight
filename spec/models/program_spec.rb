# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Program, type: :model do
   describe '#association' do
      context 'related to place' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:place)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that program belongs to place' do
            program = create(:model_program, :start_from_this)
            expect(program.place).to be_truthy
         end
      end

      context 'related to event_programs' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:event_programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that program has many event_programs' do
            expect{ create(:model_program, :start_from_this) }.to change(EventProgram, :count).by(1)
         end
      end

      context 'destroying dependency' do
         let(:program) { create(:model_program, :start_from_this) }
         let(:another_program) { create(:another_program, :start_from_this) }
         before(:each) do
            program.destroy
         end

         it "doesn't delete relative place" do
            expect(program.place).to be_truthy
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

      it 'is valid with title, category, shimai, duration, and place_id' do
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
