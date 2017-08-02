require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
   include SpecTesthelper

   describe 'GET #edit' do
      let(:event) { create(:model_event) }
      let!(:user_event) { create(:model_user_event) }
      before(:each) do
         @user = event.user_events.find_by(organizer: true).user
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
      let(:ticket) { create(:model_ticket) }
      let!(:user_event) { create(:model_user_event) }
      before(:each) do
         @event = ticket.event
         @user = @event.user_events.find_by(organizer: true).user
      end

      context 'with valid param in create action' do
         let(:diff_ticket) { create(:diff_ticket) }
         before(:each) do
            login_as(@user)
            @ticket_params = {'0': { type: 'create',
                                     id: '',
                                     event_id: ticket.event_id,
                                     grade: 'Sample',
                                     price: '1000' }}
         end

         it 'creates a new ticket' do
            expect{ patch :update,
                    id: @event,
                    ticket: @ticket_params }.to change(Ticket, :count).by(1)
         end

         it 'is redirected to Event#event_port action' do
            patch :update, id: @event, ticket: @ticket_params
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'with valid param in update action' do
         before(:each) do
            login_as(@user)
            patch :update, id: @event, ticket: { '0': { type: 'update',
                                                        id: ticket.id,
                                                        event_id: ticket.event_id,
                                                        grade: 'Hyper',
                                                        price: '1000' } }
         end

         it 'updates ticket attributes' do
            ticket.reload
            expect(ticket.grade).to eq('Hyper')
         end

         it 'is redirected to Event#event_port action' do
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'with valid param in destroy action' do
         before(:each) do
            login_as(@user)
            @ticket_params = {'0': { type: 'destroy',
                                     id: ticket.id }}
         end

         it 'destroys a ticket' do
            expect{ patch :update,
                    id: @event,
                    ticket: @ticket_params }.to change(Ticket, :count).by(-1)
         end

         it 'is redirected to Event#event_port action' do
            patch :update, id: @event, ticket: @ticket_params
            expect(response).to redirect_to(edit_event_port_url(@event))
         end
      end

      context 'without login' do
         let(:ticket) { create(:model_ticket) }

         it "doesn't create a new ticket" do
            ticket_params = {'0': { type: 'create',
                                    id: '',
                                    event_id: ticket.event_id,
                                    grade: 'Sample',
                                    price: 1000 }}
            expect{ patch :update,
                    id: @event,
                    ticket: ticket_params }.to change(Ticket, :count).by(0)
         end

         it "doesn't update a ticket" do
            patch :update, id: @event, ticket: {'0': { type: 'update',
                                                       id: ticket.id,
                                                       event_id: ticket.event_id,
                                                       grade: 'Hyper',
                                                       price: ticket.price }}
            ticket.reload
            expect(ticket.grade).not_to eq('Hyper')
         end

         it "doesn't destroy a ticket" do
            ticket_params = {'0': { type: 'destroy',
                                    id: ticket.id,
                                    event_id: ticket.event_id,
                                    grade: ticket.grade,
                                    price: ticket.price }}
            expect{ patch :update,
                    id: @event,
                    ticket: ticket_params }.to change(Ticket, :count).by(0)
         end

         it 'is redirected to login action' do
            ticket_params = {'0': { type: 'create',
                                    id: '',
                                    event_id: ticket.event_id,
                                    grade: 'Sample',
                                    price: 1000 }}
            patch :update, id: @event, ticket: ticket_params
            expect(response).to redirect_to(login_url)
         end
      end

      context 'with invalid or empty required param' do
         let(:ticket) { create(:model_ticket) }
         before(:each) do
            login_as(@user)
         end

         it "doesn't create a new ticket" do
            ticket_params = {'0': { type: 'create',
                                    id: '',
                                    event_id: ticket.event_id,
                                    grade: '',
                                    price: '1000' }}
            expect{ patch :update,
                    id: @event,
                    ticket: ticket_params }.to change(Ticket, :count).by(0)
         end

         it "doesn't update a ticket" do
            patch :update, id: @event, ticket: {'0': { type: 'update',
                                                       id: ticket.id,
                                                       event_id: ticket.event_id,
                                                       grade: '',
                                                       price: ticket.price }}
            ticket.reload
            expect(ticket.grade).not_to eq('')
         end

         it 'is redirected to edit action' do
            ticket_params = {'0': { type: 'create',
                                    id: ticket.id,
                                    event_id: ticket.event_id,
                                    grade: '',
                                    price: ticket.price }}
            patch :update, id: @event, ticket: ticket_params
            expect(response).to redirect_to(edit_ticket_url(@event))
         end
      end
   end
end
