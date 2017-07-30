require 'rails_helper'

RSpec.describe EventsController, type: :controller do
   include SpecTesthelper

   describe 'GET #index' do
      before(:each) do
         @search_params = { search: { start_date: '',
                                      end_date:   '',
                                      keywd:      '',
                                      locations:  '' } }
      end

      context 'with no params' do
         it 'returns response status with 200' do
            get :index, params: @search_params
            expect(response.status).to eq(200)
         end
      end

      context 'with search params' do
         let!(:event) { create(:model_event) }
         let!(:place) { create(:model_place) }
         let!(:program) { create(:model_program) }
         let!(:style) { create(:model_style) }
         let!(:performer) { create(:model_performer) }
         let!(:event_program) { create(:model_event_program) }
         let!(:event_performer) { create(:model_event_performer) }

         it 'returns specified results relative to keywd param connected to event title' do
            @search_params[:search][:keywd] = event.title
         end

         it 'returns specified results relative to keywd param connected to event programs' do
            @search_params[:search][:keywd] = program.title
         end

         it 'returns specified results relative to keywd param connected to event performers' do
            @search_params[:search][:keywd] = performer.full_name
         end

         it 'returns specified results relative to start date param ' do
            @search_params[:search][:start_date] = event.start_date
         end

         it 'returns specified results relative to end date param ' do
            @search_params[:search][:end_date] = event.start_date
         end

         it 'returns specified results relative to locations param' do
            @search_params[:search][:locations] = place.title
         end

         after(:example) do
            get :index, params: @search_params
            expect(assigns(:events).first).to eq(event)
         end
      end
   end

   describe 'GET #new' do
      let(:user) { create(:model_user) }

      context 'with login' do
         it "returns response status with 200" do
            login_as(user)
            get :new
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it "is redirected to login action" do
            get :new
            expect(response).to redirect_to(login_url)
         end
      end
   end

   describe 'GET #show' do
      context 'with event param' do
         let(:user) { create(:model_user) }
         let(:event) { create(:model_event) }
         before(:each) do
            login_as(user)
            get :show, id: event
         end

         it 'assigns an event' do
            expect(assigns(:event)).to eq(event)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without event param' do
         it 'occurs an error' do
            expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'GET #edit' do
      let!(:user) { create(:model_user) }
      let!(:event) { create(:model_event) }
      let!(:user_event) { create(:model_user_event) }

      context 'with event param' do
         before(:each) do
            login_as(user)
            get :edit, id: event
         end

         it 'assign edit event' do
            expect(assigns(:event)).to eq(event)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :edit, id: event
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without event param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :edit }.to raise_error(ActionController::UrlGenerationError)
         end
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:diff_event) }
         it 'is redirect_to root action' do
            login_as(user)
            get :edit, id: diff_event
            expect(response).to redirect_to(root_url)
         end
      end
   end

   describe 'POST #create' do
      let(:user) { create(:model_user) }

      context 'with valid param' do
         let(:event) { attributes_for(:model_event) }
         before(:each) do
            login_as(user)
         end
         it 'creates a new event to the database' do
            expect{ post :create, event: { title: event[:title] } }.to change(Event, :count).by(1)
         end

         it 'is redirected to edit_port action' do
            post :create, event: { title: event[:title] }
            expect(response).to redirect_to(edit_event_port_url(Event.last))
         end
      end

      context 'without login' do
         let(:event) { attributes_for(:model_event) }

         it "doesn't create a new event" do
            expect{ post :create, event: { title: event[:title] } }.to change(Event, :count).by(0)
         end

         it 'is redirected to login action' do
            post :create, event: { title: event[:title] }
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with invalid event param' do
         before(:each) do
            login_as(user)
         end

         it "doesn't create a new event" do
            expect{ post :create, event: { title: '' } }.to change(Event, :count).by(0)
         end

         it 'renders edit template' do
            post :create, event: { title: '' }
            expect(response).to render_template(:new)
         end
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:model_user) }
      let(:event) { create(:model_event) }
      let!(:user_event) { create(:model_user_event) }

      context 'with valid param' do
         before(:each) do
            login_as(user)
            patch :update, id: event, event: attributes_for(:model_event, title: 'Changed Event')
         end

         it 'changes event attributes' do
            event.reload
            expect(event.title).to eq('Changed Event')
         end

         it 'is redirected to edit_port action' do
            expect(response).to redirect_to(edit_event_port_url(event))
         end
      end

      context 'without login' do
         before(:each) do
            patch :update, id: event, event: attributes_for(:model_event, title: 'Changed Event')
         end

         it "doesn't change event attributes" do
            event.reload
            expect(event.title).not_to eq('Changed Event')
         end

         it 'is redirect_to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with invalid param' do
         before(:each) do
            login_as(user)
            patch :update, id: event, event: attributes_for(:model_event, title: '')
         end

         it "doesn't change event attributes" do
            event.reload
            expect(event.title).not_to eq('Changed Event')
         end

         it 'renders edit template' do
            expect(response).to render_template(:edit)
         end
      end

      context 'when not editor of the event' do
         let!(:diff_event) { create(:diff_event) }
         before(:each) do
            login_as(user)
            patch :update, id: diff_event, event: attributes_for(:model_event, title: 'Changed Event')
         end

         it "doesn't change event attributes" do
            diff_event.reload
            expect(diff_event.title).not_to eq('Changed Event')
         end

         it 'is redirect_to root action' do
            expect(response).to redirect_to(root_url)
         end
      end

   end

   describe 'DELETE #destroy' do
      let!(:user) { create(:model_user) }
      let!(:event) { create(:model_event) }
      let!(:user_event) { create(:model_user_event) }

      context 'in a correct way' do
         before(:each) do
            login_as(user)
         end

         it 'destroys the event' do
            expect{ delete :destroy, id: event }.to change(Event, :count).by(-1)
         end

         it "is redirected to manage action" do
            delete :destroy, id: event
            expect(response).to redirect_to(event_manage_url)
         end
      end

      context 'without login' do
         it "doesn't destroy the event" do
            expect{ delete :destroy, id: event }.to change(Event, :count).by(0)
         end

         it 'is redirect_to login action' do
            delete :destroy, id: event
            expect(response).to redirect_to(login_url)
         end
      end

      context 'when not editor of the event' do
         let!(:diff_event) { create(:diff_event) }
         before(:each) do
            login_as(user)
         end

         it "doesn't destroy the event" do
            expect{ delete :destroy, id: diff_event }.to change(Event, :count).by(0)
         end

         it 'is redirect_to root action' do
            delete :destroy, id: diff_event
            expect(response).to redirect_to(root_url)
         end
      end
   end

   describe 'GET #manage' do
      let!(:user) { create(:model_user) }

      context 'with event param' do
         before(:each) do
            login_as(user)
            get :manage
         end

         it 'assign manage user' do
            expect(assigns(:user)).to eq(user)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :manage
            expect(response).to redirect_to(login_url)
         end
      end
   end

   describe 'GET edit_port' do
      let!(:user) { create(:model_user) }
      let!(:event) { create(:model_event) }
      let!(:user_event) { create(:model_user_event) }

      context 'with event param' do
         before(:each) do
            login_as(user)
            get :edit_port, id: event
         end

         it 'assign edit event' do
            expect(assigns(:event)).to eq(event)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :edit_port, id: event
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without event param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :edit_port }.to raise_error(ActionController::UrlGenerationError)
         end
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:diff_event) }
         it 'is redirect_to root action' do
            login_as(user)
            get :edit_port, id: diff_event
            expect(response).to redirect_to(root_url)
         end
      end
   end

   describe 'GET #edit_place' do
      let!(:user) { create(:model_user) }
      let!(:event) { create(:model_event) }
      let!(:user_event) { create(:model_user_event) }

      context 'with event param' do
         before(:each) do
            login_as(user)
            get :edit_place, id: event
         end

         it 'assign edit event' do
            expect(assigns(:event)).to eq(event)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :edit_place, id: event
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without event param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :edit_place }.to raise_error(ActionController::UrlGenerationError)
         end
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:diff_event) }
         it 'is redirect_to root action' do
            login_as(user)
            get :edit_place, id: diff_event
            expect(response).to redirect_to(root_url)
         end
      end
   end

   describe 'PATCH #update_place' do
      let(:user) { create(:model_user) }
      let(:place) { create(:model_place) }
      let(:event) { create(:model_event) }
      let!(:user_event) { create(:model_user_event) }

      context 'with valid event_place param existing in Place class' do
         let(:alter_place) { create(:alter_place) }
         before(:each) do
            login_as(user)
            patch :update_place, id: event, event_place: { title: alter_place.title }
         end

         it 'updates event location' do
            event.reload
            expect(event.place_id).to eq(alter_place.id)
         end

         it 'is redirected to edit_port action' do
            expect(response).to redirect_to(edit_event_port_url(event))
         end
      end

      context 'with valid event_place param not existing in Place' do
         let(:alter_place) { attributes_for(:alter_place) }
         before(:each) do
            login_as(user)
         end

         it 'creates a new place' do
            expect{ patch :update_place, id: event, event_place: alter_place }.to change(Place, :count).by(1)
         end

         it 'updates event location' do
            patch :update_place, id: event, event_place: alter_place
            event.reload
            expect(event.place_id).to eq(Place.last.id)
         end

         it 'is redirected to edit_port action' do
            patch :update_place, id: event, event_place: alter_place
            expect(response).to redirect_to(edit_event_port_url(event))
         end
      end

      context 'without login' do
         let(:alter_place) { create(:alter_place) }
         it 'is redirected to login action' do
            patch :update_place, id: event, event_place: { title: alter_place[:title] }
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with invalid event_place param' do
         let(:alter_place) { create(:alter_place) }
         before(:each) do
            login_as(user)
            patch :update_place, id: event, event_place: { title: '' }
         end

         it 'updates event location' do
            event.reload
            expect(event.place_id).not_to eq(alter_place.id)
         end

         it 'is redirected to edit_place action' do
            expect(response).to redirect_to(edit_event_place_url(event))
         end
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:diff_event) }
         let(:alter_place) { create(:alter_place) }

         it 'is redirect_to root action' do
            login_as(user)
            patch :update_place, id: diff_event, event_place: { title: alter_place[:title] }
            expect(response).to redirect_to(root_url)
         end
      end
   end
end
