require 'rails_helper'
# TODO: updateアクションに各パラメータが変更できたかのテストも追加

RSpec.describe EventsController, type: :controller do
   include SpecTesthelper

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
      # 下記ユーザーに関連するイベント群を同時に作成(全5件)
      let!(:user) { create(:search_user) }

      shared_examples 'returning number of results' do
         before(:each) do
            @event_count = @events.count
            @events = @events.limit(5)
         end
         it { expect(assigns(:event_count)).to eq(@event_count) }
         it { expect(assigns(:events).count).to eq(@events.count) }
         it { expect(response).to have_http_status(200) }
      end

      context 'without params' do
         before(:each) do
            # FIXME: userからリレーションする以外の方法でテストをパスしたい
            get :index
            @events = Event.where(published: true)
         end

         it_behaves_like('returning number of results')
      end

      context 'with easy search params' do

         context 'with valid keywd params for programs' do
            let(:program_params) { attributes_for(:first_search_program) }
            before(:each) do
               program_title = program_params[:title]
               programs = Program.where(title: program_title)
               ev_programs = EventProgram.where(program_id: programs.ids)
               @events = Event.where(id: ev_programs.pluck(:event_id))
               get :index, easy_search: { keywd: program_title }
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid keywd params for performers' do
            let(:performer_params) { attributes_for(:first_search_performer) }
            before(:each) do
               performer_full_name = performer_params[:full_name]
               performers = Performer.where(full_name: performer_full_name)
               ev_performers = EventPerformer.where(performer_id: performers.ids)
               ev_programs = EventProgram.where(id: ev_performers.pluck(:event_program_id))
               @events = Event.where(id: ev_programs.pluck(:event_id))
               get :index, easy_search: { keywd: performer_full_name }
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid keywd params for events' do
            let(:event_params) { attributes_for(:first_search_event) }
            before(:each) do
               event_title = event_params[:title][0..2]
               @events = Event.where("title LIKE '%#{event_title}%'")
               get :index, easy_search: { keywd: event_title }
            end

            it_behaves_like('returning number of results')
         end

         context 'with unmatched keywd params' do
            before(:each) do
               get :index, easy_search: { keywd: '???????' }
               @events = Event.where("title LIKE '%???????%'")
            end

            it_behaves_like('returning number of results')
         end
      end

      context 'with detailed search params' do
         before(:each) do
            @search_params = { start_date: '',
                               end_date: '',
                               program: '',
                               performer: '',
                               keywd:  '',
                               locations: '' }
         end

         context 'with valid start_date params' do
            let(:event_params) { attributes_for(:first_search_event) }
            before(:each) do
               start_date = event_params[:start_date]
               @events = Event.where(start_date: start_date)
               @search_params[:start_date] = start_date
               get :index, search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid end_date params' do
            let(:event_params) { attributes_for(:first_search_event) }
            before(:each) do
               end_date = event_params[:start_date]
               @events = Event.where(start_date: end_date)
               @search_params[:end_date] = end_date
               get :index, search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid locations params' do
            let(:place_params) { attributes_for(:first_search_place) }
            before(:each) do
               location_address = place_params[:address]
               locations = Place.where(address: location_address)
               @events = Event.where(place_id: locations.ids)
               @search_params[:locations] = location_address
               get :index, search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid keywd params for programs' do
            let(:program_params) { attributes_for(:first_search_program) }
            before(:each) do
               program_title = program_params[:title]
               programs = Program.where(title: program_title)
               ev_programs = EventProgram.where(program_id: programs.ids)
               @events = Event.where(id: ev_programs.pluck(:event_id))
               @search_params[:keywd] = program_title
               get :index, search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid keywd params for performers' do
            let(:performer_params) { attributes_for(:first_search_performer) }
            before(:each) do
               performer_full_name = performer_params[:full_name]
               performers = Performer.where(full_name: performer_full_name)
               ev_performers = EventPerformer.where(performer_id: performers.ids)
               ev_programs = EventProgram.where(id: ev_performers.pluck(:event_program_id))
               @events = Event.where(id: ev_programs.pluck(:event_id))
               @search_params[:keywd] = performer_full_name
               get :index, search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid keywd params for events' do
            let(:event_params) { attributes_for(:first_search_event) }
            before(:each) do
               event_title = event_params[:title][0..2]
               @events = Event.where("title LIKE '%#{event_title}%'")
               @search_params[:keywd] = event_title
               get :index, search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with unmatched keywd params' do
            before(:each) do
               @search_params[:keywd] = '???????'
               get :index, search: @search_params
               @events = Event.where("title LIKE '%#{@search_params[:keywd]}%'")
            end

            it_behaves_like('returning number of results')
         end
      end

      context 'with user params' do
         context 'with valid params' do
            before(:each) do
               @events = user.events
               get :index, user: user
            end

            it_behaves_like('returning number of results')
         end

         context 'with invalid params' do
            it 'occurs an error' do
               expect{ get :index, user: '???????' }.to raise_error(ActiveRecord::RecordNotFound)
            end

            it "returns response status 404" do
               pending "it needs to get response status 404 from its controller and relative view"
               get :index, user: '???????'
               expect(response).to have_http_status(404)
            end
         end
      end

   end


   describe 'GET #new' do
      let(:user) { create(:controller_user) }

      context 'with login' do
         before(:each) do
            login_as(user)
            get :new
         end

         it 'assigns @event as a new' do
            expect(assigns(:event)).to be_a_new(Event)
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

   describe 'GET #show' do
      let(:event) { create(:controller_event) }

      context 'with event params' do
         before(:each) do
            get :show, id: event
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(event)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without event params' do
         it_behaves_like('occurs an error', 'show')
      end
   end

   describe 'GET #edit' do
      let(:event) { create(:controller_event, :start_from_this) }

      context 'with event param' do
         before(:each) do
            user = event.users.first
            login_as(user)
            get :edit, id: event
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(event)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without login' do
         before(:each) do
            get :edit, id: event
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'without event param' do
         before(:each) do
            user = event.users.first
            login_as(user)
         end

         it_behaves_like('occurs an error', 'edit')
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:different_event) }
         before(:each) do
            user = event.users.first
            login_as(user)
            get :edit, id: diff_event
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'POST #create' do
      let(:user) { create(:controller_user) }

      context 'with valid params' do
         let(:event_params) { attributes_for(:controller_event) }
         before(:each) do |example|
            login_as(user)
            post :create, event: { title: event_params[:title] } unless example.metadata[:skip_before]
         end

         it 'assigns @event as a created one' do
            expect(assigns(:event)).to be_persisted
         end

         it 'creates a new event into a database', :skip_before do
            expect{ post :create, event: { title: event_params[:title] } }.to change(Event, :count).by(1)
         end

         it 'creates a new user_event into a datavase', :skip_before do
            expect{ post :create, event: { title: event_params[:title] } }.to change(UserEvent, :count).by(1)
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirect_to edit_event_port action' do
            expect(response).to redirect_to(edit_event_port_url(assigns(:event)))
         end
      end

      context 'without login' do
         let(:event_params) { attributes_for(:controller_event) }
         before(:each) do |example|
            post :create, event: { title: event_params[:title] } unless example.metadata[:skip_before]
         end

         it "doesn't create an event", :skip_before do
            expect{ post :create, event: { title: event_params[:title] } }.to change(Event, :count).by(0)
         end

         it "doesn't create a user_event", :skip_before do
            expect{ post :create, event: { title: event_params[:title] } }.to change(UserEvent, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with invalid params' do
         let(:event_params) { attributes_for(:controller_event, :invalid_params) }
         before(:each) do |example|
            login_as(user)
            post :create, event: { title: event_params[:title] } unless example.metadata[:skip_before]
         end

         it "doesn't create an event", :skip_before do
            expect{ post :create, event: { title: event_params[:title] } }.to change(Event, :count).by(0)
         end

         it "doesn't create a user_event", :skip_before do
            expect{ post :create, event: { title: event_params[:title] } }.to change(UserEvent, :count).by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:controller_user, :start_from_this) }
      before(:each) do
         @event = user.events.first
      end

      context 'with valid params' do
         before(:each) do
            login_as(user)
            patch :update, id: @event, event: attributes_for(:controller_event, title: 'Changed Event')
         end

         it 'changes event attributes' do
            @event.reload
            expect(@event.title).to eq('Changed Event')
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to edit_event_port action' do
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'without login' do
         before(:each) do
            patch :update, id: @event, event: attributes_for(:controller_event, title: 'Changed Event')
         end

         it "doesn't change event attributes" do
            @event.reload
            expect(@event.title).not_to eq('Changed Event')
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with invalid param' do
         before(:each) do
            login_as(user)
            patch :update, id: @event, event: attributes_for(:controller_event, title: '')
         end

         it "doesn't change event attributes" do
            @event.reload
            expect(@event.title).not_to eq('Changed Event')
         end

         it_behaves_like('returning success response', true, 'edit')
      end

      context 'when not editor of this event' do
         let(:diff_event) { create(:different_event) }
         before(:each) do
            login_as(user)
            patch :update, id: diff_event, event: attributes_for(:different_event, title: 'Changed Event')
         end

         it "doesn't change event attributes" do
            diff_event.reload
            expect(diff_event.title).not_to eq('Changed Event')
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'DELETE #destroy' do
      let(:user) { create(:controller_user, :start_from_this) }
      before(:each) do
         @event = user.events.first
      end

      context 'with valid event params' do
         before(:each) do |example|
            login_as(user)
            delete :destroy, id: @event unless example.metadata[:skip_before]
         end

         it 'destroys event', :skip_before do
            expect{ delete :destroy, id: @event }.to change(Event, :count).by(-1)
         end

         it_behaves_like('returning redirection response', '/manage')
      end

      context 'without login' do
         before(:each) do |example|
             delete :destroy, id: @event unless example.metadata[:skip_before]
         end

         it "doesn't destroy event", :skip_before do
            expect{ delete :destroy, id: @event }.to change(Event, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'when not editor of the event' do
         let!(:diff_event) { create(:different_event) }
         before(:each) do |example|
            login_as(user)
            delete :destroy, id: diff_event unless example.metadata[:skip_before]
         end

         it "doesn't destroy event", :skip_before do
            expect{ delete :destroy, id: diff_event }.to change(Event, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'GET #manage' do
      let!(:user) { create(:controller_user) }

      context 'with valid params' do
         before(:each) do
            @events = user.events
            @organizer_ids = user.user_events.where(organizer: true).pluck(:event_id)
            @editor_ids = user.user_events.where(organizer: false).pluck(:event_id)

            login_as(user)
            get :manage
         end

         it 'assigns @user' do
            expect(assigns(:user)).to eq(user)
         end

         it 'assigns @events' do
            expect(assigns(:events)).to eq(@events)
         end

         it 'assigns @organizer_ids' do
            expect(assigns(:organizer_ids)).to eq(@organizer_ids)
         end

         it 'assigns @editor_ids' do
            expect(assigns(:editor_ids)).to eq(@editor_ids)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without login' do
         before(:each) do
            get :manage
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end

   describe 'GET edit_port' do
      let(:user) { create(:controller_user, :start_from_this) }

      context 'with valid params' do
         before(:each) do
            @event = user.events.first
            login_as(user)
            get :edit_port, id: @event
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(@event)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without event params' do
         before(:each) do
            login_as(user)
         end

         it_behaves_like('occurs an error', 'edit_port')
      end

      context 'without login' do
         before(:each) do
            @event = user.events.first
            get :edit_port, id: @event
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:different_event) }
         before(:each) do
            login_as(user)
            get :edit_port, id: diff_event
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'GET #edit_place' do
      let(:user) { create(:controller_user, :start_from_this) }

      context 'with event params' do
         before(:each) do
            @event = user.events.first
            @place = @event.place
            @places = Place.all
            login_as(user)
            get :edit_place, id: @event
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(@event)
         end

         it 'assigns @place' do
            expect(assigns(:place)).to eq(@place)
         end

         it 'assigns @places' do
            expect(assigns(:places)).to eq(@places)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without event params' do
         before(:each) do
            login_as(user)
         end

         it_behaves_like('occurs an error', 'edit_place')
      end

      context 'without login' do
         before(:each) do
            @event = user.events.first
            get :edit_place, id: @event
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:different_event) }
         before(:each) do
            login_as(user)
            get :edit_place, id: diff_event
         end

         it_behaves_like('returning redirection response', '/')
      end
   end

   describe 'PATCH #update_place' do
      let(:user) { create(:controller_user, :start_from_this) }

      context 'with valid title params' do
         let(:diff_place) { create(:different_place) }
         before(:each) do
            @event = user.events.first
            login_as(user)
            patch :update_place, id: @event, event_place: { title: diff_place.title, mode: 'update' }
         end

         it 'changes event location' do
            @event.reload
            expect(@event.place_id).to eq(diff_place.id)
         end

         it 'returns response status 302' do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to edit_port action' do
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'with valid title params that is not existing in Place' do
         let(:diff_place_params) { attributes_for(:different_place) }
         before(:each) do |example|
            @event = user.events.first
            diff_place_params[:mode] = 'update'
            login_as(user)
            patch :update_place, id: @event, event_place: diff_place_params unless example.metadata[:skip_before]
         end

         it 'creates a new place into a database', :skip_before do
            expect{ patch :update_place, id: @event, event_place: diff_place_params }.to change(Place, :count).by(1)
         end

         it 'changes event location' do
            @event.reload
            expect(@event.place_id).to eq(Place.last.id)
         end

         it 'is redirected to edit_port action' do
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'without login' do
         let(:diff_place) { create(:different_place) }
         before(:each) do
            @event = user.events.first
            patch :update_place, id: @event, event_place: { title: diff_place.title, mode: 'update' }
         end

         it "doesn't change event attributes" do
            @event.reload
            expect(@event.title).not_to eq('Changed Event')
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with invalid event_place param' do
         let(:place_params) { attributes_for(:controller_place) }
         before(:each) do
            @event = user.events.first
            login_as(user)
            patch :update_place, id: @event, event_place: { title: '', mode: 'update' }
         end

         it "doesn't change event attributes" do
            @event.reload
            expect(@event.place.title).to eq(place_params[:title])
         end

         # FIXME: renderアクションに変更したい
         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirected to edit_event_place action' do
            expect(response).to redirect_to(edit_event_place_url(@event))
         end
      end

      context 'when not editor of the event' do
         let(:diff_event) { create(:different_event) }
         let(:place_params) { attributes_for(:controller_place) }
         before(:each) do
            @place = diff_event.place
            login_as(user)
            patch :update_place, id: diff_event, event_place: { title: place_params[:title], mode: 'update' }
         end

         it "doesn't change event attributes" do
            diff_event.reload
            expect(diff_event.place.title).to eq(@place.title)
         end

         it_behaves_like('returning redirection response', '/')
      end
   end
end
