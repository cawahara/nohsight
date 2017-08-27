require 'rails_helper'

RSpec.describe PlacesController, type: :controller do
   include SpecTesthelper

      let(:user) { create(:controller_user) }

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

      describe 'GET #index' do
         context 'when logged user accesses' do
         end
         context 'without log in' do
         end
      end

      describe 'GET #show' do
         let(:place) { create(:controller_place, :place_show_action) }

         context 'with place params' do
            before(:each) do
               login_as(user)
               @events = place.events.limit(3)
               get :show, id: place
            end

            it 'assigns @place' do
               expect(assigns(:place)).to eq(place)
            end

            it 'gets 3 events' do
               expect(assigns(:events).count).to eq(3)
            end

            it_behaves_like('returning success response', false)
         end

         context 'without login' do
            before(:each) do
               get :show, id: place
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'without place params' do
            before(:each) do
               login_as(user)
            end

            it_behaves_like('occurs an error', 'show')
         end
      end

      describe 'GET #new' do
         context 'accessing normally' do
            before(:each) do
               login_as(user)
               get :new
            end

            it 'assigns @place as a new' do
               expect(assigns(:place)).to be_a_new(Place)
            end

            it_behaves_like('returning success response', false)
         end

         context 'without login' do
            before(:each) do
               get :new
            end

            it_behaves_like('returning redirection response', '/login')
         end
      end

      describe 'GET #edit' do
         let(:place) { create(:controller_place) }

         context 'with place params' do
            before(:each) do
               login_as(user)
               get :edit, id: place
            end

            it 'assigns @place' do
               expect(assigns(:place)).to eq(place)
            end

            it_behaves_like('returning success response', false)
         end

         context 'without login' do
            before(:each) do
               get :edit, id: place
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'without place params' do
            before(:each) do
               login_as(user)
            end

            it_behaves_like('occurs an error', 'edit')
         end
      end

      describe 'POST #create' do
         context 'with valid params' do
            let(:place_params) { attributes_for(:controller_place) }
            before(:each) do |example|
               login_as(user)
               post :create, place: place_params unless example.metadata[:skip_before]
            end

            it 'assigns @place as a created one' do
               expect(assigns(:place)).to be_persisted
            end

            it 'creates a new place into the database', :skip_before do
               expect{ post :create, place: place_params }.to change(Place, :count).by(1)
            end

            it "returns response status 302" do
               expect(response).to have_http_status(302)
            end

            it 'is redirect_to show action' do
               expect(response).to redirect_to(place_url(assigns(:place)))
            end
         end
         context 'without login' do
            let(:place_params) { attributes_for(:controller_place) }
            before(:each) do |example|
               post :create, place: place_params unless example.metadata[:skip_before]
            end

            it "doesn't create a place", :skip_before do
               expect{ post :create, place: place_params }.to change(Place, :count).by(0)
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid params' do
            let(:place_params) { attributes_for(:controller_place, :invalid_params) }
            before(:each) do |example|
               login_as(user)
               post :create, place: place_params unless example.metadata[:skip_before]
            end

            it "doesn't create a place", :skip_before do
               expect{ post :create, place: place_params }.to change(Place, :count).by(0)
            end

            it_behaves_like('returning success response', true, 'new')
         end
      end

      describe 'PATCH #update' do
         let(:place) { create(:controller_place) }

         context 'with valid params' do
            before(:each) do
               login_as(user)
               patch :update, id: place, place: attributes_for(:controller_place, title: 'Changed Place')
            end

            it 'changes place attributes' do
               place.reload
               expect(place.title).to eq('Changed Place')
            end

            it "returns response status 302" do
               expect(response).to have_http_status(302)
            end

            it 'is redirect_to show action' do
               expect(response).to redirect_to(place_url(assigns(:place)))
            end
         end

         context 'without login' do
            before(:each) do
               patch :update, id: place, place: attributes_for(:controller_place, title: 'Changed Place')
            end

            it "doesn't change place attributes" do
               place.reload
               expect(place.title).not_to eq('Changed Place')
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid param' do
            before(:each) do
               login_as(user)
               patch :update, id: place, place: attributes_for(:controller_place, title: '')
            end

            it "doesn't change place attributes" do
               place.reload
               expect(place.title).not_to eq('')
            end

            it_behaves_like('returning success response', true, 'edit')
         end
      end

      describe 'DELETE #destroy' do
         let!(:place) { create(:controller_place) }

         context 'with valid place params' do
            before(:each) do |example|
               login_as(user)
               delete :destroy, id: place unless example.metadata[:skip_before]
            end

            it 'destroys place', :skip_before do
               expect{ delete :destroy, id: place }.to change(Place, :count).by(-1)
            end

            it_behaves_like('returning redirection response', '/places')
         end

         context 'without login' do
            before(:each) do |example|
                delete :destroy, id: place unless example.metadata[:skip_before]
            end

            it "doesn't destroy place", :skip_before do
               expect{ delete :destroy, id: place }.to change(Place, :count).by(0)
            end

            it_behaves_like('returning redirection response', '/login')
         end
      end
end
