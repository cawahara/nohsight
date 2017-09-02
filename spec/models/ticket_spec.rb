# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ticket, type: :model do
   describe '#association' do
      context 'related to event' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:event)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that ticket belongs to event' do
            ticket = create(:model_ticket)
            expect(ticket.event).to be_truthy
         end
      end

      context 'destroying dependency' do
         let(:ticket) { create(:model_ticket) }
         before(:each) do
            ticket.destroy
         end

         it "doesn't delete relative event" do
            expect(ticket.event).to be_truthy
         end
      end
   end

   describe '#validation' do
      let(:ticket) { build(:model_ticket) }

      it 'is valid with event_id, grade, and price' do
         expect(ticket).to be_valid
      end

      context 'event_id' do
         it 'is invalid with empty event_id' do
            ticket.event_id = nil
            ticket.valid?
            expect(ticket.errors[:event_id]).to include("can't be blank")
         end
      end

      context 'grade' do
         it 'is invalid with empty grade' do
            ticket.grade = nil
            ticket.valid?
            expect(ticket.errors[:grade]).to include("can't be blank")
         end
      end

      context 'price' do
         it 'is invalid with empty price' do
            ticket.price = nil
            ticket.valid?
            expect(ticket.errors[:price]).to include("can't be blank")
         end
      end
   end

   describe '#method' do
      let(:ticket) { build(:model_ticket) }

      it 'returns required columns' do
         expect(Ticket.required_columns).to eq(['event_id', 'grade', 'price'])
      end

      it 'chomp_currency removes string around integer on price field' do
         ticket.price = '3dollers'
         expect(ticket).to be_valid
      end
   end
end
