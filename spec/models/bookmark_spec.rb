require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  context '#association' do
     context 'related to user' do
      it "is 'belongs to' attribute" do
          association = described_class.reflect_on_association(:user)
          expect(association.macro).to eq(:belongs_to)
      end

      it 'shows that bookmark belongs to user' do
          bookmark = create(:model_bookmark)
          expect(bookmark.user).to be_truthy
      end
     end

     context 'related to event' do
        it "is 'belongs to' attribute" do
           association = described_class.reflect_on_association(:event)
           expect(association.macro).to eq(:belongs_to)
        end

        it 'shows that bookmark belongs to event' do
           bookmark = create(:model_bookmark)
           expect(bookmark.event).to be_truthy
        end
     end

     context 'destroying dependency' do
        let(:bookmark) { create(:model_bookmark) }
        before(:each) do
           bookmark.destroy
        end

        it "doesn't delete relative user" do
           expect(bookmark.user).to be_truthy
        end

        it "doesn't delete relative event" do
           expect(bookmark.event).to be_truthy
        end
     end
  end

  context '#validation' do
     let(:bookmark) { build(:model_bookmark) }

     it 'is valid with user_id, and event_id' do
        expect(bookmark).to be_valid
     end

     context 'user_id' do
        it 'is invalid with empty user_id' do
           bookmark.user_id = nil
           bookmark.valid?
           expect(bookmark.errors[:user_id]).to include("can't be blank")
        end
     end

     context 'event_id' do
        it 'is invalid with empty event_id' do
           bookmark.event_id = nil
           bookmark.valid?
           expect(bookmark.errors[:event_id]).to include("can't be blank")
        end

        it 'is invalid when same user bookmarks same event' do
           bookmark.save
           dup_bookmark = bookmark.dup
           dup_bookmark.valid?
           expect(dup_bookmark.errors[:event_id]).to include("has already been bookmarked")
        end
     end
  end
end
