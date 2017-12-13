# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Style, type: :model do
   describe '#association' do
      context 'related to performers' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:performers)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that style has many performers' do
            expect{ create(:model_style, :start_from_this) }.to change(Performer, :count).by(1)
         end
      end

      context 'destroying dependency' do
         let(:style) { create(:model_style, :start_from_this) }
         let(:another_style) { create(:another_style, :start_from_this) }
         before(:each) do
            style.destroy
         end

         it 'deletes relative performers' do
            expect(style.performers.count).to eq(0)
         end

         it "doesn't delete not relative perfomers" do
            expect(another_style.performers.count).not_to eq(0)
         end
      end
   end

   describe '#validation' do
      let(:style) { build(:model_style) }

      it 'is valid with title' do
         expect(style).to be_valid
      end

      context 'title' do
         it 'is invalid with empty title' do
            style.title = nil
            style.valid?
            expect(style.errors[:title]).to include("can't be blank")
         end
      end
   end
end
