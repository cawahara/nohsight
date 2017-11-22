require 'rails_helper'

RSpec.describe JoinHistoriesController, type: :controller do
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
      let(:user) { create(:controller_user, :start_from_this) }
      let!(:join_history) { create(:controller_join_history, user: user) }

      context 'accessing normally' do
         before(:each) do
            login_as(user)
            get :index
         end

         it 'assigns @join_history_status as 0' do
            expect(assigns(:join_history_status)).to eq(0)
         end

         it "assigns user's join_events filtered by join_history status 0" do
            expect(assigns(:events)).to eq(Event.where(id: user.join_histories.where(status: 0).pluck(:event_id)))
         end
      end

      context 'with status params' do
         before(:each) do
            login_as(user)
            get :index, status: 1
         end

         it 'assigns @join_history_status as 1' do
            expect(assigns(:join_history_status)).to eq("1")
         end

         it "assigns user's join_events filtered by join_history status 1" do
            expect(assigns(:events)).to eq(Event.where(id: user.join_histories.where(status: 1).pluck(:event_id)))
         end
      end

      context 'without login' do
         before(:each) do
            get :index
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:controller_user) }
      let(:diff_event) { create(:different_event, :start_from_this) }

      context 'with event params' do
         before(:each) do |example|
            @params = { id: diff_event.id, user_id: user.id }
            request.env["HTTP_ACCEPT"] = 'application/json; charset=utf-8'
            patch :update, @params, format: :json unless example.metadata[:skip_before]
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(diff_event)
         end

         it 'creates a new join_history into a database', :skip_before do
            expect{ patch :update, @params, format: :json }.to change(JoinHistory, :count).by(1)
         end

         it 'returns json format' do
            expect(response.headers["Content-Type"]).to eq('application/json; charset=utf-8')
         end
      end

      context "with event params that user already recorded" do
         let!(:join_history) { create(:controller_join_history, user: user, event: diff_event) }
         before(:each) do |example|
            @params = { id: diff_event.id, user_id: user.id }
            request.env["HTTP_ACCEPT"] = 'application/json; charset=utf-8'
            patch :update, @params, format: :json unless example.metadata[:skip_before]
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(diff_event)
         end

         it "doesn't create a new join_history", :skip_before do
            expect{ patch :update, @params, format: :json }.to change(JoinHistory, :count).by(0)
         end

         it 'returns json format' do
            expect(response.headers["Content-Type"]).to eq('application/json; charset=utf-8')
         end
      end

      context 'without login' do
         before(:each) do
            @params = { id: diff_event.id }
            request.env["HTTP_ACCEPT"] = 'application/json; charset=utf-8'
            patch :update, @params, format: :json
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end

   describe 'DELETE #destroy' do
      let(:user) { create(:controller_user) }
      let(:event) { create(:controller_event) }
      let!(:bookmark) { create(:controller_join_history, user: user, event: event) }

      context 'with event params' do
         before(:each) do |example|
            @params = { id: event.id, user_id: user.id }
            request.env["HTTP_ACCEPT"] = 'application/json; charset=utf-8'
            delete :destroy, @params, format: :json unless example.metadata[:skip_before]
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(event)
         end

         it 'destroys the join_history', :skip_before do
            expect{ patch :destroy, @params, format: :json }.to change(JoinHistory, :count).by(-1)
         end

         it 'returns json format' do
            expect(response.headers["Content-Type"]).to eq('application/json; charset=utf-8')
         end
      end

      context "with event params that user doesn't record" do
         let(:diff_event) { create(:different_event) }
         before(:each) do |example|
            @params = { id: diff_event.id, user_id: user.id }
            request.env["HTTP_ACCEPT"] = 'application/json; charset=utf-8'
            delete :destroy, @params, format: :json unless example.metadata[:skip_before]
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(diff_event)
         end

         it "doesn't destroy the join_history", :skip_before do
            expect{ patch :destroy, @params, format: :json }.to change(JoinHistory, :count).by(0)
         end

         it 'returns json format' do
            expect(response.headers["Content-Type"]).to eq('application/json; charset=utf-8')
         end
      end

      context 'without login' do
         before(:each) do
            @params = { id: event.id }
            request.env["HTTP_ACCEPT"] = 'application/json; charset=utf-8'
            delete :destroy, @params, format: :json
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end
end
