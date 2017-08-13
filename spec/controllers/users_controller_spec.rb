require 'rails_helper'

RSpec.describe UsersController, type: :controller do
   include SpecTesthelper

   describe 'GET #new' do
      context 'accessing normally' do
         before(:each) do
            get :new
         end

         it 'assigns @user' do
            expect(assigns(:user)).to be_truthy
         end

         it "returns response status 200" do
            expect(response.status).to eq(200)
         end
      end
   end

   describe 'GET #show' do
      context 'with user param' do
         let(:user) { create(:controller_user, :user_show_action) }
         before(:each) do
            user_events = []
            user.user_events.each do |user_event|
               user_events << user_event.event_id
            end
            @events = Event.where(id: user_events, published: true).limit(3)
            get :show, id: user
         end

         it 'assigns @user' do
            expect(assigns(:user)).to eq(user)
         end

         it 'assigns @events' do
            expect(assigns(:events)).to eq(@events)
         end

         it 'gets 3 events' do
            expect(assigns(:events).count).to eq(3)
         end

         it 'returns response status 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without user param' do
         it 'occurs an error' do
            # :TODO: 下記エラー発生時に専用の404ページに飛ぶ
            expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'GET #edit' do
      let(:user) { create(:controller_user) }
      context 'with user param and login' do
         before(:each) do
            login_as(user)
            get :edit, id: user
         end

         it 'assigns @user' do
            expect(assigns(:user)).to eq(user)
         end

         it 'returns response status 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         before(:each) do
            get :edit, id: user
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with different user param from logged one' do
         let(:diff_user) { create(:different_user) }
         before(:each) do
            login_as(user)
            get :edit, id: diff_user
         end

         it 'is redirected to root action' do
            expect(response).to redirect_to(root_url)
         end
      end

      context 'without user param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :edit }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'POST #create' do
      let(:user_params) { attributes_for(:controller_user) }

      context 'with valid params' do
         # FIXME: dbにないカラムの:agreementが何らかの関係でreq->headerに記載されておらず、
         # =>     dev上では動作するのにtestが通らない
         before(:each) do
            pending 'failure caused by request header not including agreement param'
         end

         it 'creates a new user into the database' do
            expect{ post :create, user: user_params }.to change(User, :count).by(1)
         end

         it 'returns response status 302' do
            post :create, user: user_params
            expect(response.status).to eq(302)
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

      context 'without agreed the site convention' do
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

         it 'returns response status 302' do
            expect(response.status).to eq(302)
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(user_url(user))
         end
      end

      context 'without login' do
         before(:each) do
            patch :update, id: user, user: attributes_for(:controller_user, name: 'Jackson')
         end

         it "doesn't change user attributes" do
            user.reload
            expect(user.name).not_to eq('Jackson')
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with different user param from logged one' do
         let(:diff_user) { create(:different_user) }
         before(:each) do
            login_as(user)
            patch :update, id: diff_user, user: attributes_for(:different_user, name: 'Jackson')
         end

         it "doesn't change user attributes" do
            diff_user.reload
            expect(user.name).not_to eq('Jackson')
         end

         it 'is redirected to root action' do
            expect(response).to redirect_to(root_url)
         end
      end

      context 'with invalid params' do
         before(:each) do
            login_as(user)
            patch :update, id: user, user: attributes_for(:controller_user, name: '')
         end

         it "doesn't change user attributes" do
            user.reload
            expect(user.name).not_to eq('')
         end

         it 'renders to edit template' do
            expect(response).to render_template(:edit)
         end
      end
   end

   describe 'DELETE #destroy' do
      let!(:user) { create(:controller_user) }

      context 'with valid user param' do
         before(:each) do
            login_as(user)
         end

         it "destroys the logged user" do
            expect{ delete :destroy, id: user }.to change(User, :count).by(-1)
         end

         it 'returns response status 302' do
            delete :destroy, id: user
            expect(response.status).to eq(302)
         end

         it "is redirected to root action" do
            delete :destroy, id: user
            expect(response).to redirect_to(root_url)
         end
      end

      context 'with different user param from logged one' do
         let!(:diff_user) { create(:different_user) }
         before(:each) do
            login_as(user)
         end

         it "doesn't destroy user" do
            expect{ delete :destroy, id: diff_user }.to change(User, :count).by(0)
         end

         it 'is redirect_to root action' do
            delete :destroy, id: diff_user
            expect(response).to redirect_to(root_url)
         end
      end

      context 'without login' do
         it "doesn't destroy user" do
            expect{ delete :destroy, id: user }.to change(User, :count).by(0)
         end

         it 'is redirect_to login action' do
            delete :destroy, id: user
            expect(response).to redirect_to(login_url)
         end
      end
   end
end
