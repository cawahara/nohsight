require 'rails_helper'

RSpec.describe EventPerformersController, type: :controller do
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

   describe 'GET #edit' do
      let(:user) { create(:controller_user) }
      let(:event) { create(:controller_event) }
      let!(:user_event) { create(:controller_user_event, user: user, event: event) }

      context 'with event params' do
         before(:each) do
            login_as(user)
            get :edit, id: event
         end

         it 'assigns edit action' do
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
            login_as(user)
         end

         it_behaves_like('occurs an error', 'edit')
      end
   end

   describe 'PATCH #update' do
      let(:user) { create(:controller_user) }
      let(:event) { create(:controller_event) }
      let!(:user_event) { create(:controller_user_event, user: user, event: event) }
      let!(:ev_program) { create(:controller_event_program, event: event) }

      context 'in create action' do
         let(:performer_params) { attributes_for(:controller_performer) }
         before(:each) do
            @ev_program_params = {'0': { mode:   'update',
                                         id:     ev_program.id } }
            @ev_performer_params = {'0': { mode:             'create',
                                           id:               '',
                                           event_program_id: ev_program.id,
                                           full_name:        performer_params[:full_name] } }
         end

         context 'with valid params' do
            before(:each) do |example|
               login_as(user)
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params unless example.metadata[:skip_before]
            end

            it 'creates a new event_performer', :skip_before do
               expect{ patch :update,
                       id: event,
                       event_program: @ev_program_params,
                       'event_performer-0': @ev_performer_params }.to change(EventPerformer, :count).by(1)
            end

            it 'creates a new performer when performer full_name is not in a database', :skip_before do
               expect{ patch :update,
                       id: event,
                       event_program: @ev_program_params,
                       'event_performer-0': @ev_performer_params }.to change(Performer, :count).by(1)
            end

            it "returns response status 302" do
               expect(response).to have_http_status(302)
            end

            it 'is redirect_to edit_event_port action' do
               expect(response).to redirect_to(edit_event_port_url(event))
            end
         end

         context 'without login' do
            before(:each) do |example|
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params unless example.metadata[:skip_before]
            end

            it "doesn't create a new event_performer", :skip_before do
               expect{ patch :update,
                       id: event,
                       event_program: @ev_program_params,
                       'event_performer-0': @ev_performer_params }.to change(EventPerformer, :count).by(0)
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid or empty params' do
            before(:each) do |example|
               login_as(user)
               @ev_performer_params[:'0'][:full_name] = nil
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params unless example.metadata[:skip_before]
            end

            it "doesn't create a new event_performer", :skip_before do
               expect{ patch :update,
                       id: event,
                       event_program: @ev_program_params,
                       'event_performer-0': @ev_performer_params }.to change(EventPerformer, :count).by(0)
            end

            it_behaves_like('returning success response', true, 'edit')
         end
      end

      context 'in update action' do
         let(:performer) { create(:controller_performer) }
         let!(:ev_performer) { create(:controller_event_performer, event_program: ev_program, performer: performer) }
         let(:performer_params) { attributes_for(:different_performer) }
         before(:each) do
            @ev_program_params = {'0': { mode:   'update',
                                         id:     ev_program.id } }
            @ev_performer_params = {'0': { mode:             'update',
                                           id:               ev_performer.id,
                                           event_program_id: ev_program.id,
                                           full_name:        performer_params[:full_name] } }
         end

         context 'with valid params' do
            before(:each) do |example|
               login_as(user)
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params unless example.metadata[:skip_before]
            end

            it 'changes the event_performer attributes' do
               ev_performer.reload
               expect(ev_performer.performer).to eq(Performer.find_by(full_name: performer_params[:full_name]))
            end

            it 'creates a new performer when performer title is not in a database', :skip_before do
               expect{ patch :update,
                       id: event,
                       event_program: @ev_program_params,
                       'event_performer-0': @ev_performer_params }.to change(Performer, :count).by(1)
            end

            it "returns response status 302" do
               expect(response).to have_http_status(302)
            end

            it 'is redirect_to edit_event_port action' do
               expect(response).to redirect_to(edit_event_port_url(event))
            end
         end

         context 'without login' do
            before(:each) do
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params
            end

            it "doesn't change the event_performer attributes" do
               ev_performer.reload
               expect(ev_performer.performer).not_to eq(Performer.find_by(full_name: performer_params[:full_name]))
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid or empty params' do
            before(:each) do
               login_as(user)
               @ev_performer_params[:'0'][:full_name] = nil
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params
            end

            it "doesn't change the event_performer attributes" do
               ev_performer.reload
               expect(ev_performer.performer).not_to eq(Performer.find_by(full_name: performer_params[:full_name]))
            end

            it_behaves_like('returning success response', true, 'edit')
         end
      end

      context 'in destroy action' do
         let(:performer) { create(:controller_performer) }
         let!(:ev_performer) { create(:controller_event_performer, event_program: ev_program, performer: performer) }
         before(:each) do
            @ev_program_params = {'0': { mode:   'update',
                                         id:     ev_program.id } }
            @ev_performer_params = {'0': { mode: 'destroy',
                                           id:   ev_performer.id } }
         end

         context 'with valid params' do
            before(:each) do |example|
               login_as(user)
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params unless example.metadata[:skip_before]
            end

            it 'destroys the event_performer', :skip_before do
               expect{ patch :update,
                       id: event,
                       event_program: @ev_program_params,
                       'event_performer-0': @ev_performer_params }.to change(EventPerformer, :count).by(-1)
            end

            it "returns response status 302" do
               expect(response).to have_http_status(302)
            end

            it 'is redirected to edit action' do
               expect(response).to redirect_to(edit_event_port_url(event))
            end
         end

         context 'without login' do
            before(:each) do |example|
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params unless example.metadata[:skip_before]
            end

            it "doesn't destroy the event_performer", :skip_before do
               expect{ patch :update,
                       id: event,
                       event_program: @ev_program_params,
                       'event_performer-0': @ev_performer_params }.to change(EventPerformer, :count).by(0)
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid or empty params' do
            before(:each) do |example|
               pending 'trying to build 404 page for activerecord error exception'
               login_as(user)
               @ev_performer_params[:'0'][:id] = nil
               patch :update, id: event, event_program: @ev_program_params, 'event_performer-0': @ev_performer_params
            end
         end
      end
   end
end
