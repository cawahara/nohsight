# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Place, type: :model do
   describe '#association' do
      context 'related to events' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:events)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that place has many user_events' do
            expect{ create(:model_place, :start_from_this) }.to change(Event, :count).by(1)
         end
      end

      context 'related to programs' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that place has many user_events' do
            expect{ create(:model_place, :start_from_this) }.to change(Program, :count).by(1)
         end
      end

      context 'destroying dependency' do
         let(:place) { create(:model_place, :start_from_this) }
         let(:another_place) { create(:another_place, :start_from_this) }
         before(:each) do
            place.destroy
         end

         it 'deletes relative events' do
            expect(place.events.count).to eq(0)
         end

         it "doesn't delete not relative events" do
            expect(another_place.events.count).not_to eq(0)
         end

         it 'deletes relative programs' do
            expect(place.programs.count).to eq(0)
         end

         it "doesn't delete not relative programs" do
            expect(another_place.programs.count).not_to eq(0)
         end
      end
   end

   describe '#validation' do
      let(:place) { build(:model_place) }

      it 'is valid with title, address, and official_url' do
         expect(place).to be_valid
      end

      context 'title' do
         it 'is invalid with empty title' do
            place.title = nil
            place.valid?
            expect(place.errors[:title]).to include("can't be blank")
         end
      end

      context 'address' do
         it 'is invalid with empty address' do
            place.address = nil
            place.valid?
            expect(place.errors[:address]).to include("can't be blank")
         end
      end
   end
end
