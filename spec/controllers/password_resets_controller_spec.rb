require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do
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
         it_behaves_like('returning success response', false)
      end
   end

   describe 'GET #edit' do
      let(:user) { create(:controller_user) }

      before(:each) do
         user.create_password_reset_token
         user.save
      end

      context 'with valid params' do
         before(:each) do
            get :edit, params: { id: user, email: user.email, token: user.password_reset_token }
         end

         it 'assigns @user' do
            expect(assigns(:user)).to eq(user)
         end

         it_behaves_like('returning success response', false)
      end

      context 'with invalid email params' do
         let(:user_params) { attributes_for(:different_user) }
         before(:each) do
            get :edit, params: { id: user, email: user_params[:email], token: user.password_reset_token }
         end

         it "doesn't assign @user" do
            expect(assigns(:user)).to be_nil
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'with invalid token params' do

         before(:each) do
            get :edit, params: { id: user, email: user.email, token: 'not confirmed' }
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'by not confirmed user' do
         before(:each) do
            user.confirmed = false
            user.save
            get :edit, params: { id: user, email: user.email, token: user.password_reset_token }
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'POST #create' do
      let(:user) { create(:controller_user) }

      context 'with valid params' do
         before(:each) do |example|
            post :create, params: { reset: { email: user.email } } unless example.metadata[:skip_before]
         end

         it 'assigns user' do
            expect(User.find_by(email: user.email)).to eq(user)
         end

         it 'sends a password_reset email', :skip_before do
            expect{ post :create, params: { reset: { email: user.email } } }.to change{ ActionMailer::Base.deliveries.size }.by(1)
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'with invalid params' do
         let(:user_params) { attributes_for(:different_user) }
         before(:each) do |example|
            post :create, params: { reset: { email: user_params[:email] } } unless example.metadata[:skip_before]
         end

         it "doesn't assign user" do
            expect(User.find_by(email: user_params[:email])).not_to eq(user.email)
         end

         it "doesn't send a password_reset email", :skip_before do
            expect{ post :create, params: { reset: { email: user_params[:email] } } }.to change{ ActionMailer::Base.deliveries.size }.by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end

      context 'by not confirmed user' do
         before(:each) do |example|
            user.confirmed = false
            user.save
            post :create, params: { reset: { email: user.email } } unless example.metadata[:skip_before]
         end

         it "doesn't send a password_reset email", :skip_before do
            expect{ post :create, params: { reset: { email: user.email } } }.to change{ ActionMailer::Base.deliveries.size }.by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:controller_user) }
      before(:each) do
         @prev_password = user.password_digest
      end

      context 'with valid params' do
         before(:each) do
            patch :update, params: { reset: { email: user.email, password: 'changed_pass', password_confirmation: 'changed_pass' } }
         end

         it 'assigns user' do
            expect(User.find_by(email: user.email)).to eq(user)
         end

         it "changes user's password" do
            user.reload
            expect(user.password_digest).not_to eq(@prev_password)
         end

         it_behaves_like('returning redirection response', '/dashboard')
      end

      context 'with invalid params' do
         before(:each) do
            patch :update, params: { reset: { email: user.email, password: 'changed_pass', password_confirmation: 'password' } }
         end

         it 'assigns user' do
            expect(User.find_by(email: user.email)).to eq(user)
         end

         it "doesn't change user's password" do
            user.reload
            expect(user.password_digest).to eq(@prev_password)
         end

      end

      context "with unsubmitted user's email" do
         let(:user_params) { attributes_for(:different_user) }
         before(:each) do
            patch :update, params: { reset: { email: user_params[:email], password: 'changed_pass', password_confirmation: 'password' } }
         end

         it "doesn't assign user" do
            expect(assigns(:user)).to be_nil
         end

         it "doesn't change user's password" do
            user.reload
            expect(user.password_digest).to eq(@prev_password)
         end

      end
   end
end
