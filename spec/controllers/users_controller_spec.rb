require 'rails_helper'

RSpec.describe UsersController, type: :controller do
   include SpecTesthelper

   describe 'GET #new' do
      context 'accessing normally' do
         before(:each) do
            get :new
         end

         it 'assigns @user as a new' do
            expect(assigns(:user)).to be_a_new(User)
         end

         it "returns response status 200" do
            expect(response).to have_http_status(200)
         end
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

         it 'assigns @events' do
            expect(assigns(:events)).to eq(@events)
         end

         it 'gets 3 events' do
            expect(assigns(:events).count).to eq(3)
         end

         it 'returns response status 200' do
            expect(response).to have_http_status(200)
         end
      end

      context 'without user params' do
         it 'occurs an error' do
            # :TODO: 下記エラー発生時に専用の404ページに飛ぶ
            expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
         end

         it "returns response status 404" do
            pending "it needs to get response status 404 from its controller and relative view"
            get :show
            expect(response).to have_http_status(404)
         end
      end
   end

   describe 'GET #edit' do
      let(:user) { create(:controller_user) }
      context 'with user params and login' do
         before(:each) do
            login_as(user)
            get :edit, id: user
         end

         it 'assigns @user' do
            expect(assigns(:user)).to eq(user)
         end

         it 'returns response status 200' do
            expect(response).to have_http_status(200)
         end
      end

      context 'without login' do
         before(:each) do
            get :edit, id: user
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with different user params from logged one' do
         let(:diff_user) { create(:different_user) }
         before(:each) do
            login_as(user)
            get :edit, id: diff_user
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to root action' do
            expect(response).to redirect_to(root_url)
         end
      end

      context 'without user params' do
         before(:each) do
            login_as(user)
         end

         it 'occurs an error' do
            expect{ get :edit }.to raise_error(ActionController::UrlGenerationError)
         end

         it "returns response status 404" do
            pending "it needs to get response status 404 from its controller and relative view"
            get :edit
            expect(response).to have_http_status(404)
         end
      end
   end

   describe 'POST #create' do
      let(:user_params) { attributes_for(:controller_user) }

      context 'with valid params' do
         it 'assigns @user as a created one' do
            post :create, user: user_params
            expect(assigns(:user)).to be_persisted
         end

         it 'creates a new user into the database' do
            expect{ post :create, user: user_params }.to change(User, :count).by(1)
         end

         it 'returns response status 302' do
            post :create, user: user_params
            expect(response).to have_http_status(302)
         end

         it 'is redirected to root url' do
            post :create, user: user_params
            expect(response).to redirect_to(root_url)
         end
      end

      context 'with invalid params' do
         before(:each) do
            user_params[:name] = nil
         end

         it "doesn't create a user" do
            expect{ post :create, user: user_params }.to change(User, :count).by(0)
         end

         it "returns response status 200" do
            post :create, user: user_params
            expect(response).to have_http_status(200)
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

         it "returns response status 200" do
            expect(response).to have_http_status(200)
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
            expect(response).to have_http_status(302)
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

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
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

         it "returns response status 200" do
            expect(response).to have_http_status(200)
         end

         it 'renders edit template' do
            expect(response).to render_template(:edit)
         end
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

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to root action' do
            expect(response).to redirect_to(root_url)
         end
      end
   end

   describe 'DELETE #destroy' do
      let!(:user) { create(:controller_user) }

      context 'with valid user params' do
         before(:each) do
            login_as(user)
         end

         it "destroys the logged user" do
            expect{ delete :destroy, id: user }.to change(User, :count).by(-1)
         end

         it 'returns response status 302' do
            delete :destroy, id: user
            expect(response).to have_http_status(302)
         end

         it "is redirected to root action" do
            delete :destroy, id: user
            expect(response).to redirect_to(root_url)
         end
      end

      context 'without login' do
         it "doesn't destroy user" do
            expect{ delete :destroy, id: user }.to change(User, :count).by(0)
         end

         it 'returns response status 302' do
            delete :destroy, id: user
            expect(response).to have_http_status(302)
         end

         it 'is redirect_to login action' do
            delete :destroy, id: user
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with different user params from logged one' do
         let!(:diff_user) { create(:different_user) }
         before(:each) do
            login_as(user)
         end

         it "doesn't destroy user" do
            expect{ delete :destroy, id: diff_user }.to change(User, :count).by(0)
         end

         it 'returns response status 302' do
            delete :destroy, id: user
            expect(response).to have_http_status(302)
         end

         it 'is redirect_to root action' do
            delete :destroy, id: diff_user
            expect(response).to redirect_to(root_url)
         end
      end
   end
end
