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
      let(:user) { create(:controller_user, confirmed: false, confirmed_at: nil) }
      let(:wrong_user) { attributes_for(:different_user) }

      context 'with valid params' do
         before(:each) do
            get :new, email: user.email, token: user.confirmation_token
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
               get :new, email: wrong_user[:email], token: user.confirmation_token
            end

            it "doesn't confirms user" do
               user.reload
               expect(user.confirmed).to eq(false)
            end
         end

         context 'token params' do
            before(:each) do
               get :new, email: wrong_user[:email], token: user.confirmation_token
            end

            it "doesn't confirms user" do
               user.reload
               expect(user.confirmed).to eq(false)
            end
         end

      end

      context 'by a user who has already been confirmed' do
         before(:each) do
            user.update_attributes!(confirmed: true)
            get :new, email: user.email, token: user.confirmation_token
         end

         it "doesn't redirect_to user action" do
            expect(response).to have_http_status(200)
         end
      end
   end
end
