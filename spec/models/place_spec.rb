require 'rails_helper'

RSpec.describe Place, type: :model do
   describe "relative associations" do
      it "has many events" do
         assc_event = described_class.reflect_on_association(:events)
         expect(assc_event.macro).to eq(:has_many)
      end

      it "has many programs" do
         assc_programs = described_class.reflect_on_association(:programs)
         expect(assc_programs.macro).to eq(:has_many)
      end
   end

   describe "assocation dependency for destroy" do
      let(:place)  { build(:model_place) }
      let(:event)  { build(:model_event) }
      let(:program)  { build(:model_program) }

      it "destroys associated events" do
         place.destroy
         expect(Event.where(id: event.id)).to be_empty
      end

      it "destroys associated programs" do
         place.destroy
         expect(Place.where(id: program.id)).to be_empty
      end
   end

   describe "validation" do
      let(:place) { build(:model_place) }

      it "is valid with title, address and official_url" do
         expect(place).to be_valid
      end

      describe "title" do
         it "is invalid without a title" do
            place.title = nil
            place.valid?
            expect(place.errors[:title]).to include("can't be blank")
         end
      end

      describe "address" do
         it "is invalid without an address" do
            place.address = nil
            place.valid?
            expect(place.errors[:address]).to include("can't be blank")
         end
      end
   end
end
