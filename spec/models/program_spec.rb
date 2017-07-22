require 'rails_helper'

RSpec.describe Program, type: :model do
   describe "relative assocations" do
      it "has many event_programs" do
         assc_ev_pro = described_class.reflect_on_association(:event_programs)
         expect(assc_ev_pro.macro).to eq(:has_many)
      end

      it "belongs to place" do
         assc_place = described_class.reflect_on_association(:place)
         expect(assc_place.macro).to eq(:belongs_to)
      end
   end

   describe "assocation dependency for destroy" do
      let(:program)  { build(:model_program) }
      let(:ev_pro)  { build(:model_event_program) }
      it "destroys associated event_programs" do
         program.destroy
         expect(EventProgram.where(id: ev_pro.id)).to be_empty
      end
   end

   describe "validation" do
      let(:program)  { build(:model_program) }

      it "is valid with title, category, shimai, duration, and place_id" do
         expect(program).to be_valid
      end

      describe "title" do
         it "is invalid without a title" do
            program.title = nil
            program.valid?
            expect(program.errors[:title]).to include("can't be blank")
         end
      end
   end
end
