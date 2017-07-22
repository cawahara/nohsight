require 'rails_helper'

RSpec.describe Style, type: :model do

   describe "relative assocations" do
      it "has many performers" do
         assc_performer = described_class.reflect_on_association(:performers)
         expect(assc_performer.macro).to eq(:has_many)
      end
   end

   describe "assocation dependency for destroy" do
      let(:style)  { build(:model_style) }
      let(:performer)  { build(:model_performer) }

      it "destroys associated performers" do
         style.destroy
         expect(Performer.where(id: performer.id)).to be_empty
      end
   end

   describe "validation" do
      let(:style)  { build(:model_style) }

      it "is valid with title" do
         expect(style).to be_valid
      end

      describe "title" do
         it "is invalid without a title" do
            style.title = nil
            style.valid?
            expect(style.errors[:title]).to include("can't be blank")
         end
      end
   end
end
