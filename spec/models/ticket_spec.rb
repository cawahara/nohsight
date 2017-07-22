require 'rails_helper'

RSpec.describe Ticket, type: :model do

   describe "relative associations" do
      it "belongs to event" do
         assc_event = described_class.reflect_on_association(:event)
         expect(assc_event.macro).to eq(:belongs_to)
      end
   end

   describe "validation" do
      let(:ticket) { build(:model_ticket) }

      it "is valid with event_id, grade and price" do
         expect(ticket).to be_valid
      end

      describe "event_id" do
         it "is invalid without an event_id" do
            ticket.event_id = nil
            ticket.valid?
            expect(ticket.errors[:event_id]).to include("can't be blank")
         end
      end

      describe "grade" do
         it "is invalid without an grade" do
            ticket.grade = nil
            ticket.valid?
            expect(ticket.errors[:grade]).to include("can't be blank")
         end
      end

      describe "price" do
         it "is invalid without an price" do
            ticket.price = nil
            ticket.valid?
            expect(ticket.errors[:price]).to include("can't be blank")
         end
      end
   end
end
