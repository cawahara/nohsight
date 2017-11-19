require 'rails_helper'

RSpec.describe AccountConfirmationsController, type: :controller do
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

   describe 'GET #new' do
      context 'accessing normally' do
         before(:each) do
            get :new
         end

         it 'assigns @email as empty' do
            expect(assigns(:email)).to be_empty
         end

         it_behaves_like('returning success response', false)
      end
   end

   describe 'GET #edit' do
      let(:user) { create(:controller_user, confirmed: false, confirmed_at: nil) }
      let(:wrong_user) { attributes_for(:different_user) }

      context 'with valid params' do
         before(:each) do
            get :edit, email: user.email, token: user.confirmation_token
         end

         it 'confirms user' do
            user.reload
            expect(user.confirmed).to eq(true)
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirect_to user action' do
            expect(response).to redirect_to(user_url(user))
         end
      end

      context 'with invalid' do
         context 'email params' do
            before(:each) do
               get :edit, email: wrong_user[:email], token: user.confirmation_token
            end

            it "doesn't confirms user" do
               user.reload
               expect(user.confirmed).to eq(false)
            end

            it_behaves_like('returning redirection response', '/')
         end

         context 'token params' do
            before(:each) do
               get :edit, email: wrong_user[:email], token: user.confirmation_token
            end

            it "doesn't confirms user" do
               user.reload
               expect(user.confirmed).to eq(false)
            end

            it_behaves_like('returning redirection response', '/')
         end

      end

      context 'by a user who has already been confirmed' do
         before(:each) do
            user.update_attributes!(confirmed: true)
            get :edit, email: user.email, token: user.confirmation_token
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'POST #create' do
      let(:user) { create(:controller_user, confirmed: false) }
      before(:each) do
         @prev_confirmation = user.confirmation_digest
      end

      context 'with valid params' do
         before(:each) do |example|
            post :create, confirmation: { email: user.email } unless example.metadata[:skip_before]
         end

         it 'assigns @email' do
            expect(assigns(:email)).to eq(user.email)
         end

         it 'changes user confirmation_digest' do
            user.reload
            expect(user.confirmation_digest).not_to eq(@prev_confirmation)
         end

         it 'sends confirmation_email', :skip_before do
            expect{ post :create, confirmation: { email: user.email } }.to change{ ActionMailer::Base.deliveries.size }.by(1)
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'with invalid params' do
         let(:user_params) { attributes_for(:different_user) }

         before(:each) do |example|
            post :create, confirmation: { email: user_params[:email] } unless example.metadata[:skip_before]
         end

         it 'assigns @email' do
            expect(assigns(:email)).not_to eq(user.email)
         end

         it "doesn't change user confirmation_digest" do
            user.reload
            expect(user.confirmation_digest).to eq(@prev_confirmation)
         end

         it "doesn't send confirmation_email", :skip_before do
            expect{ post :create, confirmation: { email: user_params[:email] } }.to change{ ActionMailer::Base.deliveries.size }.by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end

      context 'by confirmed user' do
         before(:each) do |example|
            user.confirmed = true
            user.save
            post :create, confirmation: { email: user.email } unless example.metadata[:skip_before]
         end

         it 'assigns @email' do
            expect(assigns(:email)).to eq(user.email)
         end

         it "doesn't change user confirmation_digest" do
            user.reload
            expect(user.confirmation_digest).to eq(@prev_confirmation)
         end

         it "doesn't send confirmation_email", :skip_before do
            expect{ post :create, confirmation: { email: user.email } }.to change{ ActionMailer::Base.deliveries.size }.by(0)
         end

         it_behaves_like('returning redirection response', '/')
      end
   end
end
