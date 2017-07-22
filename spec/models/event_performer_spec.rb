require 'rails_helper'

RSpec.describe EventPerformer, type: :model do
   describe "relative associations" do
      it "belongs to event_program" do
         assc_ev_pro = described_class.reflect_on_association(:event_program)
         expect(assc_ev_pro.macro).to eq(:belongs_to)
      end

      it "belongs to performer" do
         assc_per = described_class.reflect_on_association(:performer)
         expect(assc_per.macro).to eq(:belongs_to)
      end
   end

   describe "validation" do
      let(:ev_per) { build(:model_event_performer) }

      it "is valid with event_program_id and performer_id" do
         expect(ev_per).to be_valid
      end

      describe "event_program_id" do
         it "is invalid without an event_program_id" do
            ev_per.event_program_id = nil
            ev_per.valid?
            expect(ev_per.errors[:event_program_id]).to include("can't be blank")
         end
      end

      describe "performer_id" do
         it "is invalid without a performer_id" do
            ev_per.performer_id = nil
            ev_per.valid?
            expect(ev_per.errors[:performer_id]).to include("can't be blank")
         end
      end
   end
end
