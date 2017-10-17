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
            @events = Event.where(publishing_status: 3)
         end

         it_behaves_like('returning number of results')
      end

      context 'with easy search params' do
         before(:each) do
            @search_params = { start_date: '',
                               end_date: '',
                               locations: '',
                               keywd:  '' }
         end

         context 'with valid start_date params' do
            let(:event_params) { attributes_for(:first_search_event) }
            before(:each) do
               start_date = event_params[:start_date]
               @events = Event.where(start_date: start_date)
               @search_params[:start_date] = start_date
               get :index, easy_search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid end_date params' do
            let(:event_params) { attributes_for(:first_search_event) }
            before(:each) do
               end_date = event_params[:start_date]
               @events = Event.where(start_date: end_date)
               @search_params[:end_date] = end_date
               get :index, easy_search: @search_params
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
               get :index, easy_search: @search_params
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
               get :index, easy_search: @search_params
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
               get :index, easy_search: @search_params
            end

            it_behaves_like('returning number of results')
         end

         context 'with valid keywd params for events' do
            let(:event_params) { attributes_for(:first_search_event) }
            before(:each) do
               event_title = event_params[:title][0..2]
               @events = Event.where("title LIKE '%#{event_title}%'")
               @search_params[:keywd] = event_title
               get :index, easy_search: @search_params
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
                               category_0: "0",
                               category_1: "0",
                               category_2: "0",
                               category_3: "0",
                               category_4: "0",
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

      context 'with params' do
         before(:each) do
            get :show, id: event
         end

         it 'assigns @event as published' do
            expect(assigns(:event).publishing_status).to eq(event.publishing_status)
         end

         it_behaves_like('returning success response', false)
      end

      context 'with event params that is not published' do
         let(:draft) { create(:controller_event, :draft) }
         before(:each) do
            get :show, id: draft
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'without event params' do
         it_behaves_like('occurs an error', 'show')
      end
   end

   describe 'GET #edit' do
      let(:event) { create(:controller_event, :draft, :start_from_this) }

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

      context 'with event params that is not published' do
         let(:published_event) { create(:controller_event, :start_from_this) }
         before(:each) do
            user = published_event.users.first
            login_as(user)
            get :edit, id: published_event
         end

         it_behaves_like('returning redirection response', '/manage')
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
      let(:place) { create(:controller_place) }
      let(:program) { create(:controller_program) }
      let(:performer) { create(:controller_performer) }
      let(:event_params) { attributes_for(:controller_event) }
      let(:ticket_params) { attributes_for(:controller_ticket) }
      before(:each) do
         @event_params = { title:               event_params[:title],
                           open_date:           event_params[:open_date],
                           start_date:          event_params[:start_date],
                           category:            event_params[:category],
                           information:         event_params[:information],
                           official_url:        event_params[:official_url],
                           publishing_status:   0,
                           place_id:            place.id }
         @place_params = { title:        place.title,
                           address:      place.address,
                           official_url: place.official_url }
         @ev_performers_params = { '0': { id:           0,
                                          performer_id: performer.id,
                                          full_name:    performer.full_name,
                                          mode:         'create' } }
         @ev_programs_params = { '0': { id:              0,
                                        program_id:      program.id,
                                        title:           program.title,
                                        genre:           '能',
                                        event_performers: @ev_performers_params,
                                        mode:             'create' } }
         @tickets_params = { '0': { id:    0,
                                    grade: ticket_params[:grade],
                                    price: ticket_params[:price],
                                    mode:  'create' } }

         @request_params = { event:          @event_params,
                             place:          @place_params,
                             event_programs: @ev_programs_params,
                             tickets:        @tickets_params }
      end

      shared_examples 'not creating a new event' do |model|
         it { expect { post :create, @request_params }.to change(model, :count).by(0) }
         it { expect { post :create, @request_params }.to change(model, :count).by(0) } if model
         # it_behaves_like('returning success response', true, 'new')
      end

      context 'with valid params' do
         before(:each) do |example|
            login_as(user)
            post :create, @request_params unless example.metadata[:skip_before]
         end

         it 'assigns @event as a created one' do
            expect(assigns(:event)).to be_persisted
         end

         it 'creates a new event into a database', :skip_before do
            expect{ post :create, @request_params }.to change(Event, :count).by(1)
         end

         it 'creates a new event_program into a database', :skip_before do
            expect{ post :create, @request_params }.to change(EventProgram, :count).by(1)
         end

         it 'creates a new event_performer into a database', :skip_before do
            expect{ post :create, @request_params }.to change(EventPerformer, :count).by(1)
         end

         it 'creates a new ticket into a database', :skip_before do
            expect{ post :create, @request_params }.to change(Ticket, :count).by(1)
         end

         it 'creates a new user_event into a database', :skip_before do
            expect{ post :create, @request_params }.to change(UserEvent, :count).by(1)
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'updates a new event as requested for publishing' do
            expect(assigns(:event).publishing_status).to eq(1)
         end

         it 'is redirect_to edit_event_port action' do
            expect(response).to redirect_to(event_manage_url)
         end
      end

      context "with params that doesn't exist in master datas" do
         let(:diff_place) { attributes_for(:different_place) }
         let(:diff_program) { attributes_for(:different_program) }
         let(:diff_performer) { attributes_for(:different_performer) }
         before(:each) do
            login_as(user)
            @request_params[:event][:place_id] = 0
            @request_params[:place][:title] = diff_place[:title]
            @request_params[:place][:address] = diff_place[:address]
            @request_params[:event_programs][:'0'][:program_id] = 0
            @request_params[:event_programs][:'0'][:title] = diff_program[:title]
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:performer_id] = 0
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:full_name] = diff_performer[:full_name]
         end

         it 'creates a new place into a database', :skip_before do
            expect{ post :create, @request_params }.to change(Place, :count).by(1)
         end

         it 'creates a new program into a database', :skip_before do
            expect{ post :create, @request_params }.to change(Program, :count).by(1)
         end

         it 'creates a new performer into a database', :skip_before do
            expect{ post :create, @request_params }.to change(Performer, :count).by(1)
         end
      end

      context 'with original_event_id' do
         let(:diff_event) { create(:different_event, :start_from_this) }
         before(:each) do |example|
            @request_params[:event][:id] = diff_event.id
            login_as(user)
            post :create, @request_params unless example.metadata[:skip_before]
         end

         it 'assigns @event as a created one' do
            expect(assigns(:event)).to be_persisted
         end

         it 'creates a new event into a database', :skip_before do
            expect{ post :create, @request_params }.to change(Event, :count).by(1)
         end

         it 'associates a new event as the edition of original one' do
            expect(assigns(:event)).to eq(diff_event.editions.first)
         end

         it "creates a new event as an original's association", :skip_before do
            expect{ post :create, @request_params }.to change(diff_event.editions, :count).by(1)
         end
      end

      context 'in case of params with missing number of keys' do
         before(:each) do |example|
            login_as(user)
            @request_params[:event_programs][:'2'] = @ev_programs_params[:'0']
            post :create, @request_params unless example.metadata[:skip_before]
         end

         it 'assigns @event as a created one' do
            expect(assigns(:event)).to be_persisted
         end

         it 'creates a new event into a database', :skip_before do
            expect{ post :create, @request_params }.to change(Event, :count).by(1)
         end

         it 'creates two new event_programs into a database', :skip_before do
            expect{ post :create, @request_params }.to change(EventProgram, :count).by(2)
         end
      end

      context 'with invalid' do
         before(:each) do
            login_as(user)
         end

         context 'event params' do
            before(:each) do
               @request_params[:event][:title] = nil
            end
            it_behaves_like('not creating a new event', Event)
         end

         context 'place params' do
            before(:each) do
               @request_params[:event][:place_id] = 0
               @request_params[:place][:title] = nil
            end
            it_behaves_like('not creating a new event', Place)
         end

         context 'event_program params' do
            before(:each) do
               @request_params[:event_programs][:'0'][:program_id] = 0
               @request_params[:event_programs][:'0'][:title] = nil
            end
            it_behaves_like('not creating a new event', EventProgram)
         end

         context 'event_performer params' do
            before(:each) do
               @request_params[:event_programs][:'0'][:event_performers][:'0'][:performer_id] = 0
               @request_params[:event_programs][:'0'][:event_performers][:'0'][:full_name] = nil
            end
            it_behaves_like('not creating a new event', EventPerformer)
         end

         context 'ticket params' do
            before(:each) do
               @request_params[:tickets][:'0'][:grade] = nil
            end
            it_behaves_like('not creating a new event', Ticket)
         end
      end

      context 'without' do
         before(:each) do
            login_as(user)
         end

         context 'event_program params' do
            before(:each) do
               @request_params[:event_programs] = {}
            end
            it_behaves_like('not creating a new event', Event)
         end

         context 'event_performer params' do
            before(:each) do
               @request_params[:event_programs][:'0'][:event_performers] = {}
            end
            it_behaves_like('not creating a new event', Event)
         end

         context 'ticket params' do
            before(:each) do
               @request_params[:tickets] = {}
            end
            it_behaves_like('not creating a new event', Event)
         end
      end

      context 'without login' do
         before(:each) do |example|
            post :create, @request_params unless example.metadata[:skip_before]
         end

         it "doesn't create an event", :skip_before do
            expect{ post :create, @request_params }.to change(Event, :count).by(0)
         end

         it "doesn't create a user_event", :skip_before do
            expect{ post :create, @request_params }.to change(UserEvent, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:controller_user) }
      let(:event) { create(:controller_event) }
      let!(:user_event) { create(:controller_user_event, user: user, event: event) }
      let(:ev_program) { create(:controller_event_program, event: event) }
      let(:ev_performer) { create(:controller_event_performer, event_program: ev_program) }
      let(:ticket) { create(:controller_ticket, event: event) }
      before(:each) do
         @event_params = { title:               event.title,
                           open_date:           event.open_date,
                           start_date:          event.start_date,
                           category:            event.category,
                           information:         event.information,
                           official_url:        event.official_url,
                           publishing_status:   event.publishing_status,
                           place_id:            event.place_id }
         @place_params = { title:        event.place.title,
                           address:      event.place.address,
                           official_url: event.place.official_url }
         @ev_performers_params = { '0': { id:           ev_performer.id,
                                          performer_id: ev_performer.performer.id,
                                          full_name:    ev_performer.performer.full_name,
                                          mode:         'update' } }
         @ev_programs_params = { '0': { id:              ev_program.id,
                                        program_id:      ev_program.program.id,
                                        title:           ev_program.program.title,
                                        genre:           ev_program.genre,
                                        event_performers: @ev_performers_params,
                                        mode:             'update' } }
         @tickets_params = { '0': { id:    ticket.id,
                                    grade: ticket.grade,
                                    price: ticket.price,
                                    mode:  'update' } }

         @request_params = { id:             event,
                             event:          @event_params,
                             place:          @place_params,
                             event_programs: @ev_programs_params,
                             tickets:        @tickets_params }
      end

      context 'with valid event params' do
         let(:diff_event) { attributes_for(:different_event) }
         before(:each) do
            login_as(user)
            @request_params[:event][:title] = diff_event[:title]
            patch :update, @request_params
         end

         it 'changes event attributes' do
            event.reload
            expect(event.title).to eq(diff_event[:title])
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirect_to edit_event_port action' do
            expect(response).to redirect_to(event_manage_url)
         end
      end

      context "with valid params that doesn't exist in master datas" do
         let(:diff_place) { attributes_for(:different_place) }
         let(:diff_program) { attributes_for(:different_program) }
         let(:diff_performer) { attributes_for(:different_performer) }
         before(:each) do
            login_as(user)
            @request_params[:event][:place_id] = 0
            @request_params[:place][:title] = diff_place[:title]
            @request_params[:place][:address] = diff_place[:address]
            @request_params[:event_programs][:'0'][:program_id] = 0
            @request_params[:event_programs][:'0'][:title] = diff_program[:title]
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:performer_id] = 0
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:full_name] = diff_performer[:full_name]
         end

         it 'creates a new place into a database' do
            expect{ patch :update, @request_params }.to change(Place, :count).by(1)
         end

         it 'creates a new program into a database' do
            expect{ patch :update, @request_params }.to change(Program, :count).by(1)
         end

         it 'creates a new performer into a database' do
            expect{ patch :update, @request_params }.to change(Performer, :count).by(1)
         end
      end

      context 'in updating action with valid params' do
         let(:diff_program) { create(:different_program) }
         let(:diff_performer) { create(:different_performer) }
         let(:diff_ticket) { attributes_for(:different_ticket) }
         before(:each) do
            login_as(user)
            @request_params[:event_programs][:'0'][:mode] = 'update'
            @request_params[:event_programs][:'0'][:title] = diff_program.title
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:mode] = 'update'
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:full_name] = diff_performer.full_name
            @request_params[:tickets][:'0'][:mode] = 'update'
            @request_params[:tickets][:'0'][:grade] = diff_ticket[:grade]
            patch :update, @request_params
         end

         it 'changes event_program attributes' do
            ev_program.reload
            expect(ev_program.program_id).to eq(diff_program.id)
         end

         it 'changes event_performer attributes' do
            ev_performer.reload
            expect(ev_performer.performer_id).to eq(diff_performer.id)
         end

         it 'changes ticket attributes' do
            ticket.reload
            expect(ticket.grade).to eq(diff_ticket[:grade])
         end
      end

      context 'in creating action with valid params' do
         before(:each) do
            login_as(user)
            @request_params[:event_programs][:'0'][:mode] = 'create'
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:mode] = 'create'
            @request_params[:tickets][:'0'][:mode] = 'create'
         end

         it 'creates a new event_program into a database' do
            expect{ patch :update, @request_params }.to change(EventProgram, :count).by(1)
         end

         it 'creates a new event_performer into a database' do
            expect{ patch :update, @request_params }.to change(EventPerformer, :count).by(1)
         end

         it 'creates a new ticket into a database' do
            expect{ patch :update, @request_params }.to change(Ticket, :count).by(1)
         end
      end

      context 'in destroying action' do
         before(:each) do
            login_as(user)
            @request_params[:event_programs][:'0'][:mode] = 'destroy'
            @request_params[:event_programs][:'0'][:event_performers][:'0'][:mode] = 'destroy'
            @request_params[:tickets][:'0'][:mode] = 'destroy'
         end

         shared_examples 'destroying associated event items' do
            it { expect{ patch :update, @request_params }.to change(EventProgram, :count).by(-1) }
            it { expect{ patch :update, @request_params }.to change(EventPerformer, :count).by(-1) }
            it { expect{ patch :update, @request_params }.to change(Ticket, :count).by(-1) }
         end

         it_behaves_like('destroying associated event items')

         context 'with empty params' do
            before(:each) do
               login_as(user)
               @request_params[:event_programs][:'0'][:title] = nil
               @request_params[:event_programs][:'0'][:event_performers][:'0'][:full_name] = nil
               @request_params[:tickets][:'0'][:grade] = nil
            end

            it_behaves_like('destroying associated event items')
         end
      end

      context 'with invalid' do
         before(:each) do
            login_as(user)
         end

         context 'event params' do
            before(:each) do
               @request_params[:event][:title] = nil
               patch :update, @request_params
            end
            it "doesn't change the event attributes" do
               event.reload
               expect(event.title).not_to eq(@request_params[:event][:title])
            end
         end

         context 'place params' do
            before(:each) do
               @request_params[:event][:place_id] = 0
               @request_params[:place][:title] = nil
               patch :update, @request_params
            end
            it "doesn't change the place_id" do
               event.reload
               expect(event.place_id).not_to eq(@request_params[:event][:place_id])
            end
         end

         context 'event_program params' do
            before(:each) do
               @request_params[:event_programs][:'0'][:program_id] = 0
               @request_params[:event_programs][:'0'][:title] = nil
               patch :update, @request_params
            end
            it "doesn't change the event_program attributes" do
               ev_program.reload
               expect(ev_program.program_id).not_to eq(@request_params[:event_programs][:'0'][:program_id])
            end
         end

         context 'event_performer params' do
            before(:each) do
               @request_params[:event_programs][:'0'][:event_performers][:'0'][:performer_id] = 0
               @request_params[:event_programs][:'0'][:event_performers][:'0'][:full_name] = nil
               patch :update, @request_params
            end
            it "doesn't change the event_performer attributes" do
               ev_performer.reload
               expect(ev_performer.performer_id).not_to eq(@request_params[:event_programs][:'0'][:event_performers][:'0'][:performer_id])
            end
         end

         context 'ticket params' do
            before(:each) do
               @request_params[:tickets][:'0'][:grade] = nil
               patch :update, @request_params
            end
            it "doesn't change the ticket attributes" do
               ticket.reload
               expect(ticket.grade).not_to eq(@request_params[:tickets][:'0'][:grade])
            end
         end
      end

      context 'without login' do
         let(:diff_event) { attributes_for(:different_event) }
         before(:each) do
            @request_params[:event][:title] = diff_event[:title]
            patch :update, @request_params
         end

         it "doesn't change event attributes" do
            event.reload
            expect(event.title).not_to eq(diff_event[:title])
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'when not editor of this event' do
         let(:diff_event) { create(:different_event) }
         before(:each) do
            login_as(user)
            @request_params[:id] = diff_event
            patch :update, @request_params
         end

         it "doesn't change event attributes" do
            diff_event.reload
            expect(diff_event.title).not_to eq(event.title)
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
      let!(:user) { create(:controller_user, :start_from_this) }
      let!(:diff_user) { create(:different_user, :start_from_this) }

      context 'with login' do
         before(:each) do
            login_as(user)
            get :manage
         end

         it 'assigns managed @events from logged user' do
            expect(assigns(:events)).to eq(user.events)
         end

         it "doesn't assign managed @events from different user" do
            expect(assigns(:events)).not_to eq(diff_user.events)
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
         it_behaves_like('returning success response', true, 'edit_place')
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
