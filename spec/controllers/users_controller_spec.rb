require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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

   describe 'GET #new' do
      context 'accessing normally' do
         before(:each) do
            get :new
         end

         it 'assigns @user as a new' do
            expect(assigns(:user)).to be_a_new(User)
         end

         it_behaves_like('returning success response', false)
      end
   end

   describe 'GET #show' do
      context 'with user params' do
         let(:user) { create(:controller_user, :user_show_action) }
         before(:each) do
            @events = user.events.where(published: true).limit(3)
            get :show, id: user
         end

         it 'assigns @user' do
            expect(assigns(:user)).to eq(user)
         end

         it 'gets 3 events' do
            expect(assigns(:events).count).to eq(3)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without user params' do
         it_behaves_like('occurs an error', 'show')
      end
   end

   describe 'GET #edit' do
      let(:user) { create(:controller_user) }
      context 'with user params' do
         before(:each) do
            login_as(user)
            get :edit, id: user
         end

         it 'assigns @user' do
            expect(assigns(:user)).to eq(user)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without login' do
         before(:each) do
            get :edit, id: user
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with different user params from logged one' do
         let(:diff_user) { create(:different_user) }
         before(:each) do
            login_as(user)
            get :edit, id: diff_user
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'without user params' do
         before(:each) do
            login_as(user)
         end

         it_behaves_like('occurs an error', 'edit')
      end
   end

   describe 'POST #create' do
      context 'with valid params' do
         let(:user_params) { attributes_for(:controller_user) }
         before(:each) do |example|
            post :create, user: user_params unless example.metadata[:skip_before]
         end

         it 'assigns @user as a created one' do
            expect(assigns(:user)).to be_persisted
         end

         it 'creates a new user into the database', :skip_before do
            expect{ post :create, user: user_params }.to change(User, :count).by(1)
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'with invalid params' do
         let(:user_params) { attributes_for(:controller_user, :invalid_params) }
         before(:each) do |example|
            post :create, user: user_params unless example.metadata[:skip_before]
         end

         it "doesn't create a user", :skip_before do
            expect{ post :create, user: user_params }.to change(User, :count).by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end

      context 'without agreed the convention' do
         let(:user_params) { attributes_for(:controller_user, :not_agreed) }
         before(:each) do
            post :create, user: user_params
         end

         it "doesn't create a user", :skip_before do
            expect{ post :create, user: user_params }.to change(User, :count).by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:controller_user) }

      context 'with valid params' do
         before(:each) do
            login_as(user)
            patch :update, id: user, user: attributes_for(:controller_user, name: 'Jackson')
         end

         it 'changes user attributes' do
            user.reload
            expect(user.name).to eq('Jackson')
         end
      end

      context 'with invalid params' do
         before(:each) do
            login_as(user)
            patch :update, id: user, user: attributes_for(:controller_user, :invalid_params)
         end

         it "doesn't change user attributes" do
            user.reload
            expect(user.name).not_to eq('')
         end

         it_behaves_like('returning success response', true, 'edit')
      end

      context 'without login' do
         before(:each) do
            patch :update, id: user, user: attributes_for(:controller_user, name: 'Jackson')
         end

         it "doesn't change user attributes" do
            user.reload
            expect(user.name).not_to eq('Jackson')
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with different user params from logged one' do
         let(:diff_user) { create(:different_user) }
         before(:each) do
            login_as(user)
            patch :update, id: diff_user, user: attributes_for(:different_user, name: 'Jackson')
         end

         it "doesn't change user attributes" do
            diff_user.reload
            expect(diff_user.name).not_to eq('Jackson')
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'DELETE #destroy' do
      let!(:user) { create(:controller_user) }

      context 'with valid user params' do
         before(:each) do |example|
            login_as(user)
            delete :destroy, id: user unless example.metadata[:skip_before]
         end

         it "destroys the logged user", :skip_before do
            expect{ delete :destroy, id: user }.to change(User, :count).by(-1)
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'without login' do
         before(:each) do |example|
            delete :destroy, id: user unless example.metadata[:skip_before]
         end

         it "doesn't destroy user", :skip_before do
            expect{ delete :destroy, id: user }.to change(User, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with different user params from logged one' do
         let!(:diff_user) { create(:different_user) }
         before(:each) do |example|
            login_as(user)
            delete :destroy, id: diff_user unless example.metadata[:skip_before]
         end

         it "doesn't destroy user", :skip_before do
            expect{ delete :destroy, id: diff_user }.to change(User, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/')
      end
   end
end
