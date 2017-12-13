require 'rails_helper'

RSpec.describe RequestsController, type: :controller do
   include SpecTesthelper

   shared_examples 'occurs an error' do |action|
      before(:each) do
         pending "it needs to get response status 404 from its controller and relative view"
         get :action
      end
      it { expect { get :action }.to raise_error(ActionController::UrlGenerationError) }
      it { expect(response).to have_http_status(404) }
   end

   shared_examples 'returning success response' do |failed, action|
      it { expect(response).to have_http_status(200) }
      if failed == true
         it { expect(response).to render_template("#{action}") }
      end
   end

   shared_examples 'returning redirection response' do |path|
      it { expect(response).to have_http_status(302) }
      it { expect(response).to redirect_to(path) }
   end

   describe 'GET #index' do
      let(:admin_user) { create(:admin_user) }
      let(:requested_event) { create(:controller_event, :start_from_this) }
      before(:each) do
         requested_event.update_attributes!(publishing_status: 1)
      end

      context 'when admin user' do
         before(:each) do
            login_as(admin_user)
            get :index
         end

         it 'assigns requested @events' do
            expect(assigns(:events)).to eq(Event.where(publishing_status: 1))
         end

         it_behaves_like('returning success response', false)
      end

      context 'without login' do
         before(:each) do
            get :index
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end

   describe 'GET #show' do
      let(:admin_user) { create(:admin_user) }
      let(:requested_event) { create(:controller_event, :start_from_this, publishing_status: 1) }

      context 'with event params' do
         before(:each) do
            login_as(admin_user)
            get :show, params: { id: requested_event }
         end

         it 'assigns @event as requested' do
            expect(assigns(:event).publishing_status).to eq(requested_event.publishing_status)
         end

         it 'assigns @comment as a new' do
            expect(assigns(:comment)).to be_a_new(Comment)
         end

         it_behaves_like('returning success response', false)
      end

      context 'with event params that is already published' do
         let(:published_event) { create(:controller_event) }
         before(:each) do
            login_as(admin_user)
            get :show, params: { id: published_event }
         end

         it_behaves_like('returning redirection response', '/requests')
      end

      context 'without login' do
         before(:each) do
            get :show, params: { id: requested_event }
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'without event params' do
         it_behaves_like('occurs an error', 'show')
      end
   end

   describe 'PATCH #update' do
      let(:admin_user) { create(:admin_user) }
      let(:requested_event) { create(:controller_event, :start_from_this, publishing_status: 1) }
      before(:each) do |example|
         @response_params = { id: requested_event, approval: { approved: 2, comment: nil } } unless example.metadata[:edition_approval]
      end

      context 'with approved params' do
         before(:each) do |example|
            login_as(admin_user)
            @response_params[:approval][:approved] = 3
            patch :update, params: @response_params unless example.metadata[:skip_before]
         end

         it "updates event's publishing status as published" do
            requested_event.reload
            expect(requested_event.publishing_status).to eq(3)
         end

         it 'create a new point_record into a database', :skip_before do
            expect{ patch :update, params: @response_params }.to change(PointRecord, :count).by(1)
         end

         it_behaves_like('returning redirection response', '/requests')
      end

      context 'with rejected params' do
         let(:comment) { attributes_for(:controller_comment) }
         before(:each) do |example|
            login_as(admin_user)
            @response_params[:approval][:comment] = comment[:content]
            patch :update, params: @response_params unless example.metadata[:skip_before]
         end

         it "updates event's publishing status as rejected" do
            requested_event.reload
            expect(requested_event.publishing_status).to eq(2)
         end

         it 'creates a new comment into a database', :skip_before do
            expect{ patch :update, params: @response_params }.to change(Comment, :count).by(1)
         end

         it_behaves_like('returning redirection response', '/requests')
      end

      context 'when the event has been rejected for more than once' do
         let(:comment) { create(:controller_comment, event: requested_event, user: admin_user) }
         let(:diff_comment) { attributes_for(:different_comment) }
         before(:each) do |example|
            comment
            login_as(admin_user)
            @response_params[:approval][:comment] = diff_comment[:content]
            patch :update, params: @response_params unless example.metadata[:skip_before]
         end

         it "updates event's publishing status as rejected" do
            requested_event.reload
            expect(requested_event.publishing_status).to eq(2)
         end

         it "updates comment's content" do
            comment.reload
            expect(comment.content).to eq(diff_comment[:content])
         end

         it "doesn't create a new comment", :skip_before do
            expect{ patch :update, params: @response_params }.to change(Comment, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/requests')
      end

      context 'when approving publishing event as the latest edition', :edition_approval do
         let(:original_event) { create(:controller_event, :start_from_this) }
         let(:edited_event) { create(:different_event, :start_from_this, original: original_event) }

         before(:each) do |example|
            login_as(admin_user)
            @response_params = { id: edited_event, approval: { approved: 3, comment: nil } }
            unless example.metadata[:skip_before]
               patch :update, params: @response_params
               @original_event_program = original_event.event_programs.first
               @edited_event_program = edited_event.event_programs.first
            end
         end

         it "updates event's publishing status as merged" do
            edited_event.reload
            expect(edited_event.publishing_status).to eq(4)
         end

         it "updates original event's attributes" do
            original_event.reload
            expect(original_event.title).to eq(edited_event.title)
         end

         it "updates original event's event_program's contents" do
            expect(original_event.programs.first.title).to eq(edited_event.programs.first.title)
         end

         it "updates original event's event_performer's contents" do
            expect(@original_event_program.performers.first.full_name).to eq(@edited_event_program.performers.first.full_name)
         end

         it "updates original event's ticket's contents" do
            expect(original_event.tickets.first.grade).to eq(edited_event.tickets.first.grade)
         end

         it "doesn't update original event's publishing status" do
            original_event.reload
            expect(original_event.publishing_status).to eq(3)
         end

         it 'creates a new user_event into a database', :skip_before do
            expect{ patch :update, params: @response_params }.to change(UserEvent, :count).by(1)
         end

         it 'creates a new point_record into a database', :skip_before do
            expect{ patch :update, params: @response_params }.to change(PointRecord, :count).by(1)
         end

         it_behaves_like('returning redirection response', '/requests')
      end

      context 'when approving edited event by a user who has also edited the original one', :edition_approval do
         let(:original_event) { create(:controller_event, :start_from_this) }
         let(:edited_event) { create(:different_event, :start_from_this, original: original_event) }

         before(:each) do |example|
            edited_event.user_events.first.update_attributes!(user_id: original_event.users.first.id)
            login_as(admin_user)
            @response_params = { id: edited_event, approval: { approved: 3, comment: nil } }
            patch :update, params: @response_params unless example.metadata[:skip_before]
         end

         it "doesn't create a user_event", :skip_before do
            expect{ patch :update, params: @response_params }.to change(UserEvent, :count).by(0)
         end
      end

      context 'without comment along rejected params' do
         before(:each) do |example|
            login_as(admin_user)
            patch :update, params: @response_params unless example.metadata[:skip_before]
         end

         it "doesn't update event's publishing status" do
            requested_event.reload
            expect(requested_event.publishing_status).not_to eq(2)
         end

         it "doesn't create a new comment", :skip_before do
            expect{ patch :update, params: @response_params }.to change(Comment, :count).by(0)
         end

         it_behaves_like('returning success response', true, 'show')
      end

      context 'without login' do
         let(:comment) { attributes_for(:controller_comment) }
         before(:each) do
            @response_params[:approval][:comment] = comment[:content]
            patch :update, params: @response_params
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'without params' do
         before(:each) do
            pending 'There is no chance to occur sending no params action'
            login_as(admin_user)
            patch :update
         end

         it_behaves_like('occurs an error', 'show')
      end
   end
end
