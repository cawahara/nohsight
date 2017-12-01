require 'rails_helper'

RSpec.describe JoinHistory, type: :model do
   describe '#association' do
      context 'related to user' do
       it "is 'belongs to' attribute" do
           association = described_class.reflect_on_association(:user)
           expect(association.macro).to eq(:belongs_to)
       end

       it 'shows that join_history belongs to user' do
           join_history = create(:model_join_history)
           expect(join_history.user).to be_truthy
       end
      end

      context 'related to event' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:event)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that join_history belongs to event' do
            join_history = create(:model_join_history)
            expect(join_history.event).to be_truthy
         end
      end

      context 'destroying dependency' do
         let(:join_history) { create(:model_join_history) }
         before(:each) do
            join_history.destroy
         end

         it "doesn't delete relative user" do
            expect(join_history.user).to be_truthy
         end

         it "doesn't delete relative event" do
            expect(join_history.event).to be_truthy
         end
      end
   end

   describe '#validation' do
      let(:join_history) { build(:model_join_history) }

      it 'is valid with user_id, event_id, and status' do
         expect(join_history).to be_valid
      end

      context 'user_id' do
         it 'is invalid with empty user_id' do
            join_history.user_id = nil
            join_history.valid?
            expect(join_history.errors[:user_id]).to include("can't be blank")
         end
      end

      context 'event_id' do
         it 'is invalid with empty event_id' do
            join_history.event_id = nil
            join_history.valid?
            expect(join_history.errors[:event_id]).to include("can't be blank")
         end

         it 'is invalid when same user join_historys same event' do
            join_history.save
            dup_join_history = join_history.dup
            dup_join_history.valid?
            expect(dup_join_history.errors[:event_id]).to include("has already been recorded")
         end
      end

      context 'status' do
         it 'is valid with proper values' do
            valid_statuses = [0, 1]
            valid_statuses.each do |valid_status|
               join_history.status = valid_status
               expect(join_history).to be_valid
            end
         end

         it 'is invalid with improper values' do
            invalid_statuses = [12, 103]
            invalid_statuses.each do |invalid_status|
               join_history.status = invalid_status
               join_history.valid?
               expect(join_history.errors[:status]).to include('is not included in the list')
            end
         end
      end
   end
end
