require 'rails_helper'

RSpec.describe Comment, type: :model do
  context '#association' do
     context 'related to user' do
        it "is 'belongs to' attribute" do
           association = described_class.reflect_on_association(:user)
           expect(association.macro).to eq(:belongs_to)
        end

        it 'shows that comment belongs to user' do
           comment = create(:model_comment)
           expect(comment.user).to be_truthy
        end
     end

     context 'related to event' do
       it "is 'belongs to' attribute" do
          association = described_class.reflect_on_association(:event)
          expect(association.macro).to eq(:belongs_to)
       end

       it 'shows that comment belongs to event' do
          comment = create(:model_comment)
          expect(comment.event).to be_truthy
       end
     end

     context 'destroying dependency' do
        let(:comment) { create(:model_comment) }
        before(:each) do
           comment.destroy
        end

        it "doesn't delete relative user" do
           expect(comment.user).to be_truthy
        end

        it "doesn't delete relative event" do
           expect(comment.event).to be_truthy
        end
     end
  end

  context '#validation' do
     let(:comment) { build(:model_comment) }

     it 'is valid with user_id, event_id, and content' do
        expect(comment).to be_valid
     end

     context 'user_id' do
        it 'is invalid with empty user_id' do
           comment.user_id = nil
           comment.valid?
           expect(comment.errors[:user_id]).to include("can't be blank")
        end
     end

     context 'event_id' do
       it 'is invalid with empty event_id' do
          comment.event_id = nil
          comment.valid?
          expect(comment.errors[:event_id]).to include("can't be blank")
       end
     end

     context 'content' do
       it 'is invalid with empty content' do
          comment.content = nil
          comment.valid?
          expect(comment.errors[:content]).to include("can't be blank")
       end
     end
  end
end
