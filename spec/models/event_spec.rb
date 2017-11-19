# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
   describe '#association' do
      context 'related to place' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:place)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that event belongs to place' do
            event = create(:model_event)
            expect(event.place).to be_truthy
         end
      end

      context 'related to event_programs' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:event_programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many event_programs' do
            expect{ create(:model_event, :start_from_this) }.to change(EventProgram, :count).by(1)
         end
      end

      context 'related to programs through event_programs' do
         let(:event) { create(:model_event, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:programs)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated program from event' do
            expect(event.programs.first).to eq(event.event_programs.first.program)
         end
      end

      context 'related to tickets' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:tickets)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many user_events' do
            expect{ create(:model_event, :start_from_this) }.to change(Ticket, :count).by(1)
         end
      end

      context 'related to user_events' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:user_events)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many user_events' do
            expect{ create(:model_event, :start_from_this) }.to change(UserEvent, :count).by(1)
         end
      end

      context 'related to users through user_events' do
         let(:event) { create(:model_event, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:users)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated user from event' do
            expect(event.users.first).to eq(event.user_events.first.user)
         end
      end

      context 'related to comment' do
         it "is 'has one' attribute" do
            association = described_class.reflect_on_association(:comment)
            expect(association.macro).to eq(:has_one)
         end

         it 'shows that event has one comment' do
            expect{ create(:model_event, :start_from_this) }.to change(Comment, :count).by(1)
         end
      end

      context 'related to point_record' do
         it "is 'has one' attribute" do
            association = described_class.reflect_on_association(:point_record)
            expect(association.macro).to eq(:has_one)
         end

         it 'shows that event has one point_record' do
            expect{ create(:model_event, :start_from_this) }.to change(PointRecord, :count).by(1)
         end
      end

      context 'related to bookmarks' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:bookmarks)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many bookmarks' do
            expect{ create(:model_event, :start_from_this) }.to change(Bookmark, :count).by(1)
         end
      end

      context 'related to users through bookmarks' do
         let(:event) { create(:model_event, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:users)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated user from event' do
            expect(event.bookmark_users.first).to eq(event.bookmarks.first.user)
         end
      end

      context 'related to join_histories' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:join_histories)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that event has many join_histories' do
            expect{ create(:model_event, :start_from_this) }.to change(JoinHistory, :count).by(1)
         end
      end

      context 'related to users through join_histories' do
         let(:event) { create(:model_event, :start_from_this) }

         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:users)
            expect(association.macro).to eq(:has_many)
         end

         it 'is able to refer associated user from event' do
            expect(event.join_users.first).to eq(event.join_histories.first.user)
         end
      end

      context 'related to editions(itself)' do
         it "is 'has many' attribute" do
            association = described_class.reflect_on_association(:editions)
            expect(association.macro).to eq(:has_many)
         end

         it 'shows that original has many editions' do
            # 下記create時にorginalとeditionが同時に生成される
            expect{ create(:model_event, :original_edition) }.to change(Event, :count).by(2)
         end
      end

      context 'related to original(itself)' do
         it "is 'belongs to' attribute" do
            association = described_class.reflect_on_association(:original)
            expect(association.macro).to eq(:belongs_to)
         end

         it 'shows that edition belongs to original' do
            event = create(:model_event, :latest_edition)
            expect(event.original).to be_truthy
         end
      end

      context 'destroying dependency' do
         let(:event) { create(:model_event, :start_from_this) }
         let(:another_event) { create(:another_event, :start_from_this) }
         before(:each) do
            event.destroy
         end

         it "doesn't delete relative place" do
            expect(event.place).to be_truthy
         end

         it 'deletes relative event_programs' do
            expect(event.event_programs.count).to eq(0)
         end

         it "doesn't delete not relative event_programs" do
            expect(another_event.event_programs.count).not_to eq(0)
         end

         it 'deletes relative tickets' do
            expect(event.tickets.count).to eq(0)
         end

         it "doesn't delete not relative tickets" do
            expect(another_event.tickets.count).not_to eq(0)
         end

         it 'deletes relative user_events' do
            expect(event.user_events.count).to eq(0)
         end

         it "doesn't delete not relative user_events" do
            expect(another_event.user_events.count).not_to eq(0)
         end

         it 'deletes relative bookmarks' do
            expect(event.bookmarks.count).to eq(0)
         end

         it "doesn't delete not relative bookmarks" do
            expect(another_event.bookmarks.count).not_to eq(0)
         end

         it 'deletes relative join_histories' do
            expect(event.join_histories.count).to eq(0)
         end

         it "doesn't delete not relative join_histories" do
            expect(another_event.join_histories.count).not_to eq(0)
         end
      end

      context 'destroying dependency of original' do
         let(:event) { create(:model_event, :original_edition) }
         let(:another_event) { create(:another_event, :original_edition) }
         before(:each) do
            event.destroy
         end

         it 'deletes relative editions' do
            expect(event.editions.count).to eq(0)
         end

         it "doesn't delete not relative editions" do
            expect(another_event.editions.count).not_to eq(0)
         end
      end

      context 'destroying dependency of edition' do
         let(:event) { create(:model_event, :latest_edition) }
         before(:each) do
            event.destroy
         end

         it "doesn't delete relative original" do
            expect(event.original).to be_truthy
         end
      end
   end

   describe '#validation' do
      let(:event) { build(:model_event) }
      let(:event_program) { build(:model_event_program, event: event) }
      let(:event_performer) { build(:model_event_performer, event_program: event_program) }
      let(:ticket) { build(:model_ticket, event: event) }

      before(:each) do
         event.save
         event_program.save
         event_performer.save
         ticket.save
      end

      it 'is valid with title, start_date, information, official_url, and published' do
         expect(event).to be_valid
      end

      context 'title' do
         it 'is invalid with empty title' do
            event.title = nil
            event.valid?
            expect(event.errors[:title]).to include("can't be blank")
         end
      end

      context 'place_id' do
         it 'is invalid with empty place_id when send_request' do
            event.place_id = nil
            event.valid?(:send_request)
            expect(event.errors[:place_id]).to include("can't be blank")
         end
      end

      context 'open_date' do
         it 'is invalid when later than start_date' do
            event.open_date = event.start_date + 2
            event.valid?
            expect(event.errors[:open_date]).to include('should be earlier than start_date')
         end

         it 'is invalid to define with empty start_date' do
            event.start_date = nil
            event.valid?
            expect(event.errors[:open_date]).to include('should be valid after start_date is defined')
         end
      end

      context 'start_date' do
         it 'is invalid with empty start_date when send_request' do
            event.start_date = nil
            event.valid?(:send_request)
            expect(event.errors[:start_date]).to include("can't be blank")
         end
      end

      context 'official_url' do
         it 'is invalid with empty official_url when send_request' do
            event.official_url = nil
            event.valid?(:send_request)
            expect(event.errors[:official_url]).to include("can't be blank")
         end

         it 'is invalid with improper formatted url when send_request' do
            invalid_urls = ['htps://',
                            'ahttps://eventsite.com',
                            'https:/eventsite.com']
            invalid_urls.each do |invalid_url|
               event.official_url = invalid_url
               event.valid?(:send_request)
               expect(event.errors[:official_url]).to include('is invalid')
            end
         end
      end

      context 'category' do
         it 'is valid with proper values' do
            valid_categories = [0, 1, 2, 3, 4]
            valid_categories.each do |valid_category|
               event.category = valid_category
               expect(event).to be_valid
            end
         end

         it 'is invalid with improper values' do
            invalid_categories = [12, 103]
            invalid_categories.each do |invalid_category|
               event.category = invalid_category
               event.valid?
               expect(event.errors[:category]).to include('is not included in the list')
            end
         end
      end

      context 'publishing_status' do
         it 'is valid with proper values' do
            valid_status = [0, 1, 2, 3, 4]
            valid_status.each do |status|
               event.publishing_status = status
               expect(event).to be_valid
            end
         end

         it 'is invalid with improper values' do
            invalid_status = [12, nil]
            invalid_status.each do |status|
               event.publishing_status = status
               event.valid?
               expect(event.errors[:publishing_status]).to include('is not included in the list')
            end
         end
      end
   end

   describe '#method' do
      let(:event) { create(:model_event, :start_from_this) }

      context 'has_event_program?' do
         it 'defines that event is invalid without any event_program' do
            event.event_programs.delete_all
            expect(event.has_event_program?).to eq(false)
         end
      end

      context 'has_event_performer?' do
         it 'defines that event is invalid without any event_performer' do
            event.event_programs.first.event_performers.delete_all
            expect(event.has_event_performer?).to eq(false)
         end
      end

      context 'has_ticket?' do
         it 'defines that event is invalid without any event_program' do
            event.tickets.delete_all
            expect(event.has_ticket?).to eq(false)
         end
      end

      context 'editor' do
         it "shows first number of event's user" do
            expect(event.editor).to eq(event.users.first)
         end
      end

      context 'approve_original_event' do
         let(:original) { create(:model_event, :start_from_this, :original_edition) }
         before(:each) do |example|
            original.approve_original_event unless example.metadata[:skip_before]
         end

         it 'creates point_record into a database', :skip_before do
            original.point_record.destroy
            expect{ original.approve_original_event }.to change(PointRecord, :count).by(1)
         end

         it 'adds 10 point_record' do
            expect(original.point_record.point).to eq(10)
         end

         it 'updates event publishing_status to 3' do
            original.reload
            expect(original.publishing_status).to eq(3)
         end
      end

      context 'approve_edition_event' do
         let(:edition) { create(:model_event, :start_from_this, :latest_edition) }
         before(:each) do |example|
            edition.approve_edition_event unless example.metadata[:skip_before]
         end

         it 'creates point_record into a database', :skip_before do
            edition.point_record.destroy
            expect{ edition.approve_edition_event }.to change(PointRecord, :count).by(1)
         end

         it 'creates user_event into a database', :skip_before do
            edition
            expect{ edition.approve_edition_event }.to change(UserEvent, :count).by(1)
         end

         it 'adds 1 point_record' do
            expect(edition.point_record.point).to eq(1)
         end

         it 'updates event publishing_status to 4' do
            edition.reload
            expect(edition.publishing_status).to eq(4)
         end
      end

      context 'current_publishing_status' do
         it 'shows values in publishing_status constant in Event model' do
            publishing_status = [0, 1, 2, 3, 4]
            publishing_status.each do |status|
               event.publishing_status = status
               expect(event.current_publishing_status).to eq(Event::PUBLISHING_STATUS[status])
            end
         end
      end

      context 'category_name' do
         it 'shows values in category constant in Event model' do
            categories = [0, 1, 2, 3, 4]
            categories.each do |category|
               event.category = category
               expect(event.category_name).to eq(Event::CATEGORIES[category])
            end
         end
      end

      context 'is_original?' do
         let(:original) { create(:model_event, :original_edition) }
         let(:edition) { create(:model_event, :latest_edition) }

         it 'returns true when the event is original' do
            expect(original.is_original?).to eq(true)
         end

         it 'returns false when the event is edition' do
            expect(edition.is_original?).to eq(false)
         end
      end

      context 'set_value_on_category' do
         it 'gets specified value on category field as default' do
            expect(event.category).to eq(0)
         end
      end
   end
end
