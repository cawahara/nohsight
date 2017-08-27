require 'rails_helper'

RSpec.describe UserEventsController, type: :controller do
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

   describe 'POST #create' do
      let(:user) { create(:controller_user) }
      let(:diff_event) { create(:different_event) }

      context 'with event params' do
         before(:each) do |example|
            login_as(user)
            post :create, id: diff_event unless example.metadata[:skip_before]
         end

         it 'creates a new user_event into the database', :skip_before do
            expect{ post :create, id: diff_event }.to change(UserEvent, :count).by(1)
         end

         it 'defines a new user_event as not organizer' do
            expect(assigns(:user_event).organizer).to be_falsey
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to edit_port action' do
            expect(response).to redirect_to(edit_event_port_url(diff_event))
         end
      end

      context 'without login' do
         before(:each) do |example|
            post :create, id: diff_event unless example.metadata[:skip_before]
         end

         it "doesn't create a new user_event" do
            expect{ post :create, id: diff_event }.to change(UserEvent, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/login')
      end

      # TODO: 追加機能に応じてテストを追加する予定
      # TODO: 編集不可能というときの条件と処理をテスト
   end

   describe 'DELETE #destroy' do
      # TODO: 機能未実装の為コーディング未定
   end
end
