require 'rails_helper'

RSpec.describe EventProgramsController, type: :controller do
   include SpecTesthelper

   describe 'GET #edit' do
      let(:event) { create(:model_event) }
      before(:each) do
         @user = event.user
      end

      context 'with event param' do
         before(:each) do
            login_as(@user)
            get :edit, id: event
         end

         it 'assigns edit action' do
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
            login_as(@user)
            expect{ get :edit }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'PATCH #update' do
      let(:event_program) { create(:model_event_program) }
      before(:each) do
         @event = event_program.event
         @user = @event.user
      end

      context 'with valid param in create action' do
         let(:diff_program) { create(:diff_program) }
         before(:each) do
            login_as(@user)
            @ev_pro_params = {'0': { type: 'create',
                                     id: '',
                                     event_id: event_program.event_id,
                                     title: diff_program[:title],
                                     genre: 'Genre', style: 'Style' }}
         end

         it 'creates a new event program' do
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params }.to change(EventProgram, :count).by(1)
         end

         it 'creates a new relationship between event and program' do
            patch :update, id: @event, event_program: @ev_pro_params
            @event.reload
            expect(@event.event_programs.last.program).to eq(diff_program)
         end

         it 'creates a new program when a new title is init' do
            new_ev_pro_params = {'0': { type: 'create',
                                        id: '',
                                        event_id: event_program.event_id,
                                        title: 'New Program',
                                        genre: 'Genre',
                                        style: 'Style' }}
            expect{ patch :update,
                    id: @event,
                    event_program: new_ev_pro_params }.to change(Program, :count).by(1)
         end

         it 'is redirected to Event#event_port action' do
            patch :update, id: @event, event_program: @ev_pro_params
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'with valid param in update action' do
         let(:diff_program) { create(:diff_program) }

         before(:each) do
            login_as(@user)
            @ev_pro_params = {'0': { type: 'update',
                                     id: event_program.id,
                                     event_id: event_program.event_id,
                                     title: diff_program[:title],
                                     genre: 'Genre',
                                     style: 'Style' }}
            patch :update, id: @event, event_program: @ev_pro_params
         end

         it 'changes the program attributes' do
            @event.reload
            event_program.reload
            expect(event_program.program_id).to eq(diff_program.id)
         end

         it 'creates a new program when a new title is init' do
            new_ev_pro_params = {'0': { type: 'update',
                                        id: event_program.id,
                                        event_id: event_program.event_id,
                                        title: 'New Program',
                                        genre: 'Genre',
                                        style: 'Style' }}
            expect{ patch :update,
                    id: @event,
                    event_program: new_ev_pro_params }.to change(Program, :count).by(1)
         end

         it 'is redirected to Event#event_port action' do
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'with valid param in destroy action' do
         let!(:event_program) { create(:model_event_program) }
         before(:each) do
            login_as(@user)
            @ev_pro_params = {'0': { type: 'destroy',
                                     id: event_program.id }}
         end

         it 'destroys the event program' do
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params }.to change(EventProgram, :count).by(-1)
         end

         it 'is redirected to Event#event_port action' do
            patch :update, id: @event, event_program: @ev_pro_params
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'without login' do
         let(:event_program) { create(:model_event_program) }
         let(:diff_program) { create(:diff_program) }

         it "doesn't create a new event program" do
            ev_pro_params = {'0': { type: 'create',
                                    id: event_program.id,
                                    event_id: event_program.event_id,
                                    title: diff_program[:title],
                                    genre: 'Genre',
                                    style: 'Style' }}
            expect{ patch :update,
                    id: @event,
                    event_program: ev_pro_params }.to change(EventProgram, :count).by(0)
         end

         it "doesn't update the event program" do
            ev_pro_params = {'0': { type: 'update',
                                    id: '',
                                    event_id: event_program.event_id,
                                    title: diff_program[:title],
                                    genre: 'Genre',
                                    style: 'Style' }}
            patch :update, id: @event, event_program: ev_pro_params
            event_program.reload
            expect(event_program.program_id).not_to eq(diff_program.id)
         end

         it "doesn't destroy the event program" do
            ev_pro_params = {'0': { type: 'destroy',
                                    id: event_program.id }}
            expect{ patch :update, id: @event,
                    event_program: ev_pro_params }.to change(EventProgram, :count).by(0)
         end

         it 'is redirected to login action' do
            ev_pro_params = {'0': { type: 'create',
                                    id: '',
                                    event_id: event_program.event_id,
                                    title: diff_program[:title],
                                    genre: 'Genre',
                                    style: 'Style' }}
            patch :update, id: @event, event_program: ev_pro_params
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with invalid or empty required param' do
         let(:event_program) { create(:model_event_program) }
         let(:diff_program) { create(:diff_program) }
         before(:each) do
            login_as(@user)
         end

         it "doesn't create a new event program" do
            ev_pro_params = {'0': { type: 'create',
                                    id: '',
                                    event_id: event_program.event_id,
                                    title: diff_program[:title],
                                    genre: '',
                                    style: '' }}
            expect{ patch :update,
                    id: @event,
                    event_program: ev_pro_params }.to change(EventProgram, :count).by(0)
         end

         it "doesn't update a event program" do
            ev_pro_params = {'0': { type: 'update',
                                    id: event_program.id,
                                    event_id: event_program.event_id,
                                    title: diff_program[:title],
                                    genre: '',
                                    style: '' }}
            patch :update, id: @event, event_program: ev_pro_params
            event_program.reload
            expect(event_program.program_id).not_to eq(diff_program.id)
         end

         it 'is redirected to edit action' do
            ev_pro_params = {'0': { type: 'create',
                                    id: '',
                                    event_id: event_program.event_id,
                                    title: diff_program[:title],
                                    genre: '',
                                    style: '' }}
            patch :update, id: @event, event_program: ev_pro_params
            expect(response).to redirect_to(edit_event_program_url(@event))
         end
      end
   end
end
