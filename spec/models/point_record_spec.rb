# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PointRecord, type: :model do
   describe '#association' do
      context 'related to user' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:user)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that point_record belongs to user' do
            point_record = create(:model_point_record)
            expect(point_record.user).to be_truthy
         end
      end

      context 'destroying dependency' do
         let(:point_record) { create(:model_point_record) }
         before(:each) do
            point_record.destroy
         end

         it "doesn't delete relative user" do
            expect(point_record.user).to be_truthy
         end
      end
   end

   describe '#validation' do
      let(:point_record) { build(:model_point_record) }

      it 'is valid with user_id, action, and point' do
         expect(point_record).to be_valid
      end

      context 'user_id' do
         it 'is invalid with empty user_id' do
            point_record.user_id = nil
            point_record.valid?
            expect(point_record.errors[:user_id]).to include("can't be blank")
         end
      end

      context 'action' do
         it 'is invalid with empty action' do
            point_record.action = nil
            point_record.valid?
            expect(point_record.errors[:action]).to include("can't be blank")
         end
      end

      context 'point' do
         it 'is invalid with empty point' do
            point_record.point = nil
            point_record.valid?
            expect(point_record.errors[:point]).to include("can't be blank")
         end
      end
   end
end
