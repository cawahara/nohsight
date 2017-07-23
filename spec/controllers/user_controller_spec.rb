require 'rails_helper'

RSpec.describe UsersController, type: :controller do
   include SpecTesthelper

   describe 'GET #new' do
      context 'access' do
         it "assigns new action" do
            get :new
            # REVIEW: statusコードの検証でもっと良い表現がないか模索
            expect(response.status).to eq(200)
         end
      end
   end

   describe 'GET #show' do
      let(:user) { create(:model_user) }

      context 'with user param' do
         before(:each) do
            get :show, id: user
         end

         it 'assigns show action' do
            expect(assigns(:user)).to eq(user)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without user param' do
         it 'occurs an error' do
            expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'GET #edit' do
      let(:user) { create(:model_user) }

      context 'with user param' do
         before(:each) do
            login_as(user)
            get :edit, id: user
         end

         it 'assigns edit action' do
            expect(assigns(:user)).to eq(user)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :edit, id: user
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without user param' do
         it 'occurs an error' do
            login_as(user)
            expect{get :edit}.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'POST #create' do
      let(:user_params) { attributes_for(:model_user) }

      context 'with valid params' do
         # FIXME: dbにないカラムの:agreementが何らかの関係でreq->headerに記載されておらず、
         # =>     dev上では動作するのにtestが通らない
         before(:each) do
            pending 'failure caused by request header not including agreement param'
         end

         it 'saves a new user into the database' do
            expect{ post :create, user: user_params }.to change(User, :count).by(1)
         end

         it 'is redirected to root url' do
            post :create, user: user_params
            expect(response).to redirect_to(root_url)
         end
      end

      context 'with invalid params' do
         before(:each) do
            user_params['name'] = nil
         end

         it "doesn't create a user" do
            expect{ post :create, user: user_params }.to change(User, :count).by(0)
         end

         it 'renders new template' do
            post :create, user: user_params
            expect(response).to render_template(:new)
         end
      end

      context 'without agreed' do
         before(:each) do
            user_params['agreement'] = false
         end

         it "doesn't create a user" do
            expect{ post :create, user: user_params }.to change(User, :count).by(0)
         end
         it 'renders new template' do
            post :create, user: user_params
            expect(response).to render_template(:new)
         end
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:model_user) }

      context 'with valid params' do
         before(:each) do
            login_as(user)
            patch :update, id: user, user: attributes_for(:model_user, name: 'Jackson')
         end

         it 'changes user attributes' do
            user.reload
            expect(user.name).to eq('Jackson')
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(user_url(user))
         end
      end

      context 'without login' do
         before(:each) do
            patch :update, id: user, user: attributes_for(:model_user, name: 'Jackson')
         end

         it "doesn't change user parameters" do
            user.reload
            expect(user.name).not_to eq('Jackson')
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with invalid params' do
         before(:each) do
            login_as(user)
            patch :update, id: user, user: attributes_for(:model_user, name: '')
         end

         it "doesn't change user parameters" do
            user.reload
            expect(user.name).not_to eq('')
         end

         it 'renders to edit template' do
            expect(response).to render_template(:edit)
         end
      end

      context 'in a different user' do
         let(:diff_user) { create(:diff_user) }
         before(:each) do
            login_as(user)
            patch :update, id: diff_user, user: attributes_for(:diff_user, name: 'Jackson')
            diff_user.reload
         end

         it "doesn't change different user parameters" do
            expect(user.name).not_to eq('Jackson')
         end

         it 'is redirected to root action' do
            expect(response).to redirect_to(root_url)
         end
      end
   end

   describe 'DELETE #destroy' do
      let!(:user) { create(:model_user) }

      context 'in a correct way' do
         before(:each) do
            login_as(user)
         end

         it "destroys the logged user" do
            expect{ delete :destroy, id: user }.to change(User, :count).by(-1)
         end

         it "is redirected to root action" do
            delete :destroy, id: user
            expect(response).to redirect_to(root_url)
         end
      end

      context 'without login' do
         it "doesn't destroy an own user" do
            expect{ delete :destroy, id: user }.to change(User, :count).by(0)
         end

         it 'is redirect_to login action' do
            delete :destroy, id: user
            expect(response).to redirect_to(login_url)
         end
      end

      context 'in a different user' do
         let!(:diff_user) { create(:diff_user) }
         before(:each) do
            login_as(user)
         end

         it "doesn't destroy a different user" do
            expect{ delete :destroy, id: diff_user }.to change(User, :count).by(0)
         end

         it 'is redirect_to root action' do
            delete :destroy, id: diff_user
            expect(response).to redirect_to(root_url)
         end
      end
   end
end
