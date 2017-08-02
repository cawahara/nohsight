require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
   include SpecTesthelper
=begin
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
      let(:place) { create(:model_place) }
      context 'when login with place param' do
         before(:each) do
            login_as(user)
            get :show, id: place
         end
         it 'assigns targeted place' do
            expect(assigns(:place)).to eq(place)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :show, id: place
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without place param' do
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
      let(:place) { create(:model_place) }
      context 'when login with place param' do
         before(:each) do
            login_as(user)
            get :edit, id: place
         end
         it 'assigns targeted place' do
            expect(assigns(:place)).to eq(place)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :edit, id: place
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without place param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :edit }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'POST #create' do
      let(:place_params) { attributes_for(:model_place) }

      context 'when login with valid params' do
         before(:each) do
            login_as(user)
         end

         it 'creates a new place into the database' do
            expect{ post :create, place: place_params }.to change(Place, :count).by(1)
         end

         it 'is redirected to show action' do
            post :create, place: place_params
            expect(response).to redirect_to(place_url(place))
         end
      end

      context 'without login' do
         it "doesn't creates a new place" do
            expect{ post :create, place: place_params }.to change(Place, :count).by(0)
         end

         it 'is redirected to login action' do
            post :create, place: place_params
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without valid params' do
         before(:each) do
            login_as(user)
            place_params['title'] = nil
         end

         it 'creates a new place into the database' do
            expect{ post :create, place: place_params }.to change(Place, :count).by(0)
         end

         it 'renders new template' do
            post :create, place: place_params
            expect(response).to render_template(:new)
         end
      end
   end

   describe 'PATCH #update' do
      let(:place) { create(:model_place) }
      let(:place_params) { attributes_for(:alter_place) }

      context 'when login with valid params' do
         before(:each) do
            login_as(user)
            post :update, id: place, place: place_params
         end

         it 'updates place attributes' do
            place.reload
            expect(place.title).to eq('Al_tower')
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(place_url(place))
         end
      end

      context 'without login' do
         before(:each) do
            post :update, id: place, place: place_params
         end

         it "doesn't update the place" do
            place.reload
            expect(place.title).not_to eq('Al_tower')
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without valid params' do
         before(:each) do
            login_as(user)
            place_params['title'] = nil
            post :update, id: place, place: place_params
         end

         it 'creates a new place into the database' do
            place.reload
            expect(place.title).not_to eq('Al_tower')
         end

         it 'renders new template' do
            expect(response).to render_template(:edit)
         end
      end
   end

   describe 'DELETE #destroy' do
      let!(:place) { create(:model_place) }
      let!(:alter_place) { create(:alter_place) }
      context 'when login with valid params' do
         before(:each) do
            login_as(user)
         end

         it 'destroys the place' do
            expect{ delete :create, id: place }.to change(Place, :count).by(-1)
         end

         it 'is redirected to index action' do
            expect(response).to redirect_to(places_url)
         end
      end
      context 'without login' do
         it "doesn't destroy the place" do
            expect{ delete :create, id: place }.to change(Place, :count).by(0)
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end
      context 'when trying to destroy deleted place' do
         before(:each) do
            login_as(user)
            alter_place.destroy
         end

         it "doesn't destroy the place" do
            expect{ delete :destroy, id: alter_place }.to change(Place, :count).by(0)
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(place_url(place))
         end
      end
   end
=end
end
