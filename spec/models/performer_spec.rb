# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Performer, type: :model do
   describe 'relative associations' do
      it 'belongs to style' do
         assc_style = described_class.reflect_on_association(:style)
         expect(assc_style.macro).to eq(:belongs_to)
      end

      it 'has many event_performers' do
         assc_ev_per = described_class.reflect_on_association(:event_performers)
         expect(assc_ev_per.macro).to eq(:has_many)
      end
   end

   describe 'assocation dependency for destroy' do
      let(:performer) { build(:model_performer) }
      let(:ev_per) { build(:model_event_performer) }

      it 'destroys associated event_performers' do
         performer.destroy
         expect(EventPerformer.where(id: ev_per.id)).to be_empty
      end
   end

   describe 'validation' do
      let(:performer) { build(:model_performer) }

      it 'is valid with full_name, last_name, first_name, and style_id' do
         expect(performer).to be_valid
      end

      describe 'full_name' do
         it 'is invalid without a full_name' do
            performer.full_name = nil
            performer.valid?
            expect(performer.errors[:full_name]).to include("can't be blank")
         end
      end

      describe 'last_name' do
         it 'is invalid with an improper last_name' do
            invalid_last_names = ['例え',
                                  'タトエ',
                                  'た都得',
                                  'tatoe']
            invalid_last_names.each do |invalid_last_name|
               performer.last_name = invalid_last_name
               performer.valid?
               expect(performer.errors[:last_name]).to include('is invalid')
            end
         end
      end

      describe 'first_name' do
         it 'is invalid with an improper first_name' do
            invalid_first_names = ['例え',
                                   'タトエ',
                                   'た都得',
                                   'tatoe']
            invalid_first_names.each do |invalid_first_name|
               performer.first_name = invalid_first_name
               performer.valid?
               expect(performer.errors[:first_name]).to include('is invalid')
            end
         end
      end

      describe 'style_id' do
         it 'is invalid without a style_id' do
            performer.style_id = nil
            performer.valid?
            expect(performer.errors[:style_id]).to include("can't be blank")
         end
      end
   end
end
