require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
   include SpecTesthelper

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

   let(:user) { create(:controller_user) }

   describe 'GET #new' do
      context 'accessing normally' do
         before(:each) do
            get :new
         end

         it_behaves_like('returning success response', false)
      end

      context 'with login' do
         before(:each) do
            login_as(user)
            get :new
         end

         it 'deletes user session' do
            expect(controller.session[:user_id]).to be_falsey
         end

         it_behaves_like('returning success response', false)
      end
   end

   describe 'POST #create' do
      context 'with valid params' do
         before(:each) do
            post :create, params: { session: { email: user.email, password: 'password' } }
         end

         it 'gives a session id' do
            expect(controller.session[:user_id]).to eq(user.id)
         end

         it_behaves_like('returning redirection response', '/dashboard')
      end

      context 'with invalid params' do
         before(:each) do
            post :create, params: { session: { email: user.email, password: '' } }
         end

         it "doesn't give any session id" do
            expect(controller.session[:user_id]).to be_falsey
         end

         it_behaves_like('returning success response', true, 'new')
      end

      context 'by not confirmed user' do
         before(:each) do
            user.confirmed = false
            user.save
            post :create, params: { session: { email: user.email, password: 'password' } }
         end

         it "doesn't give any session id" do
            expect(controller.session[:user_id]).to be_falsey
         end

         it_behaves_like('returning redirection response', '/dashboard')
      end
   end

   describe 'GET #destroy' do
      let(:user) { create(:model_user) }
      context 'with logged user' do
         before(:each) do
            login_as(user)
            get :destroy, id: user
         end

         it 'makes a session id empty' do
            expect(controller.session[:user_id]).to be_falsey
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'without login' do
         before(:each) do
            get :destroy, id: user
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end
end
