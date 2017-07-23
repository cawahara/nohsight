require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
   include SpecTesthelper

   describe 'GET #new' do
      context 'access' do
         it 'returns response status with 200' do
            get :new
            expect(response.status).to eq(200)
         end
      end
   end

   describe 'POST #create' do
      let(:user) { create(:model_user) }
      context 'with valid session param' do
         before(:each) do
            post :create, params: { session: { email: user.email, password: 'password' } }
         end

         it 'gives a session params' do
            expect(controller.session[:user_id]).to eq(user.id)
         end

         it 'is redirected to dashboard action' do
            expect(response).to redirect_to(dashboard_url)
         end
      end

      context 'with invalid session param' do
         before(:each) do
            post :create, params: { session: { email: user.email, password: '' } }
         end

         it 'gives a session params' do
            expect(controller.session[:user_id]).to be_nil
         end

         it 'is redirected to dashboard action' do
            expect(response).to render_template(:new)
         end
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
            expect(controller.session[:user_id]).to be_nil
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :destroy, id: user
            expect(response).to redirect_to(login_url)
         end
      end
   end
end
