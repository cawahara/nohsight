# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performer, type: :model do
   describe '#association' do
      context 'related to style' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:style)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that performer belongs to style' do
            performer = create(:model_performer)
            expect(performer.style).to be_truthy
         end
      end

      context 'related to event_performers' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:event_performers)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that performer has many event_performers' do
            expect{ create(:model_performer, :start_from_this) }.to change(EventPerformer, :count).by(1)
         end
      end

      context 'related to event_programs through event_performers' do
         let(:performer) { create(:model_performer, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:event_programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated event_program from performer' do
            expect(performer.event_programs.first).to eq(performer.event_performers.first.event_program)
         end
      end

      context 'destroying dependency' do
         let(:performer) { create(:model_performer, :start_from_this) }
         let(:another_performer) { create(:another_performer, :start_from_this) }
         before(:each) do
            performer.destroy
         end

         it "doesn't delete relative style" do
            expect(performer.style).to be_truthy
         end

         it 'deletes relative event_performers' do
            expect(performer.event_performers.count).to eq(0)
         end

         it "doesn't delete not relative event_performers" do
            expect(another_performer.event_performers.count).not_to eq(0)
         end
      end
   end

   describe '#validation' do
      let(:performer) { build(:model_performer) }

      it 'is valid with full_name, last_name, first_name, and style_id' do
         expect(performer).to be_valid
      end

      context 'full_name' do
         it 'is invalid with empty full_name' do
            performer.full_name = nil
            performer.valid?
            expect(performer.errors[:full_name]).to include("can't be blank")
         end
      end

      context 'last_name' do
         it 'is invalid with improper formatted last_name' do
            invalid_last_names = ['tanaka',
                                  '田中',
                                  'タナカ',
                                  'たなカ']
            invalid_last_names.each do |invalid_last_name|
               performer.last_name = invalid_last_name
               performer.valid?
               expect(performer.errors[:last_name]).to include('is invalid')
            end
         end
      end

      context 'first_name' do
         it 'is invalid with improper formatted first_name' do
            invalid_first_names = ['yukihiro',
                                   '幸弘',
                                   'ユキヒロ',
                                   'ゆきヒロ']
            invalid_first_names.each do |invalid_first_name|
               performer.first_name = invalid_first_name
               performer.valid?
               expect(performer.errors[:first_name]).to include('is invalid')
            end
         end
      end
   end
end
