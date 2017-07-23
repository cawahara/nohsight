require 'rails_helper'

RSpec.describe UsersController, type: :controller do
   include SpecTesthelper

   describe 'GET #new' do
      it "assigns the new" do
         get :new
         # REVIEW: statusコードの検証でもっと良い表現がないか模索
         expect(response.status).to eq(200)
      end
   end

   describe 'GET #show' do
      let(:user) { create(:model_user) }

      it "assigns the show with the requested user" do
         get :show, id: user
         expect(assigns(:user)).to eq(user)
         expect(response.status).to eq(200)
      end

      it "doesn't assign the show without any requested user" do
         expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
      end
   end

   describe 'GET #edit' do
      let(:user) { create(:model_user) }

      it "assigns the edit with the requested user" do
         login_as(user)
         get :edit, id: user
         expect(assigns(:user)).to eq(user)
         expect(response.status).to eq(200)
      end

      it "doesn't assigns the edit without login" do
         get :edit, id: user
         expect(response).to redirect_to(login_url)
      end

      it "doesn't assign the edit without any requested user" do
         expect{get :edit}.to raise_error(ActionController::UrlGenerationError)
      end
   end

   describe 'POST #create' do
      let(:user_params) { attributes_for(:model_user) }

      it "saves a new user into the database" do
         # FIXME: dbにないカラムの:agreementが何らかの関係でreq->headerに記載されておらず、
         # =>     dev上では動作するのにtestが通らない
         pending 'failure caused by request header not including agreement param'

         expect{ post :create, user: user_params }.to change(User, :count).by(1)
         expect(response).to redirect_to(dashboard_url)
      end

      it "is failed to save a new user when required params are completed" do
         user_params['name'] = nil
         expect{ post :create, user: user_params }.to change(User, :count).by(0)
         post :create, user: user_params
         expect(response).to render_template(:new)
      end

      it "is failed to save a new user when agreement is not filled" do
         user_params['agreement'] = false
         expect{ post :create, user: user_params }.to change(User, :count).by(0)
         post :create, user: user_params
         expect(response).to render_template(:new)
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:model_user) }
      let(:diff_user) { create(:diff_user) }

      it "changes user attributes" do
         login_as(user)
         params = attributes_for(:model_user, name: 'Jackson')
         patch :update, id: user, user: params
         user.reload
         expect(user.name).to eq('Jackson')
         expect(response).to redirect_to(user_url(user))
      end

      it "doesn't accept update action without login" do
         params = attributes_for(:model_user, name: 'Jackson')
         patch :update, id: user, user: params
         user.reload
         expect(user.name).not_to eq('Jackson')
         expect(response).to redirect_to(login_url)
      end

      it "doesn't change any user attributes when invalid values are sent" do
         login_as(user)
         params = attributes_for(:model_user, name: '')
         patch :update, id: user, user: params
         user.reload
         expect(user.name).not_to eq('')
         expect(response).to render_template(:edit)
      end

      it "doesn't accept update action with different user params" do
         login_as(user)
         params = attributes_for(:diff_user, name: 'Jackson')
         patch :update, id: diff_user, user: params
         diff_user.reload
         expect(user.name).not_to eq('Jackson')
         expect(response).to redirect_to(root_url)
      end
   end

   describe 'DELETE #destroy' do
      let!(:user) { create(:model_user) }
      let!(:diff_user) { create(:diff_user) }

      it "destroys the logged user" do
         login_as(user)
         expect{ delete :destroy, id: user }.to change(User, :count).by(-1)
         expect(response).to redirect_to(dashboard_url)
      end

      it "doesn't accept destroy action without login" do
         expect{ delete :destroy, id: user }.to change(User, :count).by(0)
         expect(response).to redirect_to(login_url)
      end

      it "doesn't accept destroy action with different user params" do
         login_as(user)
         expect{ delete :destroy, id: diff_user }.to change(User, :count).by(0)
         expect(response).to redirect_to(root_url)
      end
   end
end
