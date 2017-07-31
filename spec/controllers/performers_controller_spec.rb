require 'rails_helper'

RSpec.describe PerformersController, type: :controller do
   include SpecTesthelper

   let(:user) { create(:model_user) }

   describe 'GET #index' do
      context 'when logged user accesses' do
         before(:each) do
            login_as(user)
            get :index
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without log in' do
         it 'is redirected to login action' do
            get :index
            expect(response).to redirect_to(login_url)
         end
      end
   end

   describe 'GET #show' do
      let(:performer) { create(:model_performer) }
      context 'when login with performer param' do
         before(:each) do
            login_as(user)
            get :show, id: performer
         end
         it 'assigns targeted performer' do
            expect(assigns(:performer)).to eq(performer)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :show, id: performer
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without performer param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'GET #new' do
      context 'when logged user accesses' do
         before(:each) do
            login_as(user)
            get :new
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without log in' do
         it 'is redirected to login action' do
            get :new
            expect(response).to redirect_to(login_url)
         end
      end
   end

   describe 'GET #edit' do
      let(:performer) { create(:model_performer) }
      context 'when login with performer param' do
         before(:each) do
            login_as(user)
            get :edit, id: performer
         end
         it 'assigns targeted performer' do
            expect(assigns(:performer)).to eq(performer)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :edit, id: performer
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without performer param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :edit }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'POST #create' do
      let(:performer_params) { attributes_for(:model_performer) }

      context 'when login with valid params' do
         before(:each) do
            login_as(user)
         end

         it 'creates a new performer into the database' do
            expect{ post :create, performer: performer_params }.to change(Performer, :count).by(1)
         end

         it 'is redirected to show action' do
            post :create, performer: performer_params
            expect(response).to redirect_to(performer_url(performer))
         end
      end

      context 'without login' do
         it "doesn't creates a new performer" do
            expect{ post :create, performer: performer_params }.to change(Performer, :count).by(0)
         end

         it 'is redirected to login action' do
            post :create, performer: performer_params
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without valid params' do
         before(:each) do
            login_as(user)
            performer_params['title'] = nil
         end

         it 'creates a new performer into the database' do
            expect{ post :create, performer: performer_params }.to change(Performer, :count).by(0)
         end

         it 'renders new template' do
            post :create, performer: performer_params
            expect(response).to render_template(:new)
         end
      end
   end

   describe 'PATCH #update' do
      let(:performer) { create(:model_performer) }
      let(:performer_params) { attributes_for(:diff_performer) }

      context 'when login with valid params' do
         before(:each) do
            login_as(user)
            post :update, id: performer, performer: performer_params
         end

         it 'updates performer attributes' do
            performer.reload
            expect(performer.full_name).to eq('田中 光圀')
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(performer_url(performer))
         end
      end

      context 'without login' do
         before(:each) do
            post :update, id: performer, performer: performer_params
         end

         it "doesn't update the performer" do
            performer.reload
            expect(performer.full_name).not_to eq('田中 光圀')
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without valid params' do
         before(:each) do
            login_as(user)
            performer_params['title'] = nil
            post :update, id: performer, performer: performer_params
         end

         it 'creates a new performer into the database' do
            performer.reload
            expect(performer.full_name).not_to eq('田中 光圀')
         end

         it 'renders new template' do
            expect(response).to render_template(:edit)
         end
      end
   end

   describe 'DELETE #destroy' do
      let!(:performer) { create(:model_performer) }
      let!(:diff_performer) { create(:diff_performer) }
      context 'when login with valid params' do
         before(:each) do
            login_as(user)
         end

         it 'destroys the performer' do
            expect{ delete :create, id: performer }.to change(Performer, :count).by(-1)
         end

         it 'is redirected to index action' do
            expect(response).to redirect_to(performers_url)
         end
      end
      context 'without login' do
         it "doesn't destroy the performer" do
            expect{ delete :create, id: performer }.to change(Performer, :count).by(0)
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end
      context 'when trying to destroy deleted performer' do
         before(:each) do
            login_as(user)
            diff_performer.destroy
         end

         it "doesn't destroy the performer" do
            expect{ delete :destroy, id: diff_performer }.to change(Performer, :count).by(0)
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(performer_url(performer))
         end
      end
   end
end
