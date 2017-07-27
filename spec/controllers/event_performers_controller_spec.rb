require 'rails_helper'

RSpec.describe EventPerformersController, type: :controller do
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
      let(:event_performer) { create(:model_event_performer) }
      let!(:style) { create(:model_style) }
      before(:each) do
         @event_program = event_performer.event_program
         @event = @event_program.event
         @user = @event.user
      end

      context 'with valid param in create action' do
         let(:diff_performer) { create(:diff_performer) }
         before(:each) do
            login_as(@user)
            @ev_pro_params = {'0': { type: 'update',
                                     id: @event_program.id } }
            @ev_per_params = {'0': { type: 'create',
                                     id: '',
                                     event_program_id: event_performer.event_program_id,
                                     full_name: diff_performer[:full_name] } }
         end

         it 'creates a new event program' do
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params,
                    "event_performer-0": @ev_per_params }.to change(EventPerformer, :count).by(1)
         end

         it 'creates a new relationship between event and program' do
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": @ev_per_params
            @event_program.reload
            expect(@event_program.event_performers.last.performer).to eq(diff_performer)
         end

         it 'creates a new performer when a new name is init' do
            new_ev_per_params = {'0': { type: 'create',
                                        id: '',
                                        event_program_id: event_performer.event_program_id,
                                        full_name: 'New Performer' } }
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params,
                    "event_performer-0": new_ev_per_params }.to change(Performer, :count).by(1)
         end

         it 'is redirected to Event#event_port action' do
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": @ev_per_params
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'with valid param in update action' do
         let(:diff_performer) { create(:diff_performer) }
         before(:each) do
            login_as(@user)
            @ev_pro_params = {'0': { type: 'update',
                                     id: @event_program.id } }
            @ev_per_params = {'0': { type: 'update',
                                     id: event_performer.id,
                                     event_program_id: event_performer.event_program_id,
                                     full_name: diff_performer[:full_name] } }
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": @ev_per_params
         end

         it 'changes the event performer attributes' do
            @event.reload
            event_performer.reload
            expect(event_performer.performer_id).to eq(diff_performer.id)
         end

         it 'creates a new performer when a new name is init' do
            new_ev_per_params = {'0': { type: 'update',
                                        id: event_performer.id,
                                        event_program_id: event_performer.event_program_id,
                                        full_name: 'New Performer' } }
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params,
                    "event_performer-0": new_ev_per_params }.to change(Performer, :count).by(1)
         end

         it 'is redirected to Event#event_port action' do
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'with valid param in destroy action' do
         before(:each) do
            login_as(@user)
            @ev_pro_params = {'0': { type: 'update',
                                     id: @event_program.id } }
            @ev_per_params = {'0': { type: 'destroy',
                                     id: event_performer.id,
                                     event_program_id: event_performer.event_program_id } }
         end

         it 'destroys the event perfomer' do
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params,
                    "event_performer-0": @ev_per_params }.to change(EventPerformer, :count).by(-1)
         end

         it 'is redirected to Event#event_port action' do
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": @ev_per_params
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'without login' do
         let(:diff_performer) { create(:diff_performer) }
         before(:each) do
            @ev_pro_params = {'0': { type: 'update',
                                     id: @event_program.id } }
         end

         it "doesn't create a new event performer" do
            ev_per_params = {'0': { type: 'create',
                                    id: '',
                                    event_program_id: event_performer.event_program.id,
                                    full_name: diff_performer[:full_name] } }
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params,
                    "event_performer-0": ev_per_params }.to change(EventPerformer, :count).by(0)
         end

         it "doesn't update the event performer" do
            ev_per_params = {'0': { type: 'update',
                                    id: event_performer.id,
                                    event_program_id: event_performer.event_program.id,
                                    full_name: diff_performer[:full_name] } }
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": ev_per_params
            event_performer.reload
            expect(event_performer.performer_id).not_to eq(diff_performer.id)
         end

         it "doesn't destroy the event performer" do
            ev_per_params = {'0': { type: 'destroy',
                                    id: event_performer.id, event_performer: event_performer.event_program.id } }
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params,
                    "event_performer-0": ev_per_params }.to change(EventPerformer, :count).by(0)
         end

         it 'is redirected to login action' do
            ev_per_params = {'0': { type: 'create',
                                    id: '', event_program_id: event_performer.event_program.id,
                                    full_name: diff_performer[:full_name] } }
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": ev_per_params
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with invalid or empty required param' do
         let(:diff_performer) { create(:diff_performer) }
         before(:each) do
            login_as(@user)
            @ev_pro_params = {'0': { type: 'update',
                                     id: @event_program.id } }
         end

         it "doesn't create a new event performer" do
            ev_per_params = {'0': { type: 'create',
                                    id: event_performer.id,
                                    event_program_id: event_performer.event_program.id,
                                    full_name: '' } }
            expect{ patch :update,
                    id: @event,
                    event_program: @ev_pro_params,
                    "event_performer-0": ev_per_params }.to change(EventPerformer, :count).by(0)
         end

         it "doesn't update a event performer" do
            ev_per_params = {'0': { type: 'update',
                                    id: event_performer.id,
                                    event_program_id: event_performer.event_program.id,
                                    full_name: '' } }
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": ev_per_params
            event_performer.reload
            expect(event_performer.performer_id).not_to eq(diff_performer.id)
         end

         it 'is redirected to edit action' do
            ev_per_params = {'0': { type: 'create',
                                    id: event_performer.id,
                                    event_program_id: event_performer.event_program.id,
                                    full_name: '' } }
            patch :update, id: @event, event_program: @ev_pro_params, "event_performer-0": ev_per_params
            expect(response).to redirect_to(edit_event_performer_url(@event))
         end
      end
   end
end
