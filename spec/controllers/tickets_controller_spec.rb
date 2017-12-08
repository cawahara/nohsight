require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
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
            get :edit, params: { id: event }
         end

         it 'assigns edit action' do
            expect(assigns(:event)).to eq(event)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without login' do
         before(:each) do
            get :edit, params: { id: event }
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

      context 'in create action' do
         let(:ticket_params) { attributes_for(:controller_ticket) }
         before(:each) do
            @ticket_params = {'0': { mode:     'create',
                                     id:       '',
                                     event_id: event.id,
                                     grade:    ticket_params[:grade],
                                     price:    ticket_params[:price] } }
         end

         context 'with valid params' do
            before(:each) do |example|
               login_as(user)
               patch :update, params: { id: event, ticket: @ticket_params } unless example.metadata[:skip_before]
            end

            it 'creates a new ticket', :skip_before do
               expect{ patch :update,
                       params: {
                         id: event,
                         ticket: @ticket_params
                       } }.to change(Ticket, :count).by(1)
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
               patch :update, params: { id: event, ticket: @ticket_params } unless example.metadata[:skip_before]
            end

            it "doesn't create a new ticket", :skip_before do
               expect{ patch :update,
                       params: {
                         id: event,
                         ticket: @ticket_params
                       } }.to change(Ticket, :count).by(0)
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid or empty params' do
            before(:each) do |example|
               login_as(user)
               @ticket_params[:'0'][:grade] = nil
               patch :update, params: { id: event, ticket: @ticket_params } unless example.metadata[:skip_before]
            end

            it "doesn't create a new ticket", :skip_before do
               expect{ patch :update,
                       params: {
                         id: event,
                         ticket: @ticket_params
                       } }.to change(Ticket, :count).by(0)
            end

            it_behaves_like('returning success response', true, 'edit')
         end
      end

      context 'in update action' do
         let(:ticket) { create(:controller_ticket) }
         let(:ticket_params) { attributes_for(:different_ticket) }
         before(:each) do
            @ticket_params = {'0': { mode:     'update',
                                     id:       ticket.id,
                                     event_id: event.id,
                                     grade:    ticket_params[:grade],
                                     price:    ticket.price } }
         end

         context 'with valid params' do
            before(:each) do |example|
               login_as(user)
               patch :update, params: { id: event, ticket: @ticket_params }
            end

            it 'changes the ticket attributes' do
               ticket.reload
               expect(ticket.grade).to eq(ticket_params[:grade])
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
               patch :update, params: { id: event, ticket: @ticket_params }
            end

            it "doesn't change the ticket attributes" do
               ticket.reload
               expect(ticket.grade).not_to eq(ticket_params[:grade])
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid or empty params' do
            before(:each) do
               login_as(user)
               @ticket_params[:'0'][:grade] = nil
               patch :update, params: { id: event, ticket: @ticket_params }
            end

            it "doesn't change the ticket attributes" do
               ticket.reload
               expect(ticket.grade).not_to eq(ticket_params[:grade])
            end

            it_behaves_like('returning success response', true, 'edit')
         end
      end

      context 'in destroy action' do
         let(:ticket) { create(:controller_ticket) }
         before(:each) do
            @ticket_params = {'0': { mode:     'destroy',
                                     id:       ticket.id } }
         end

         context 'with valid params' do
            before(:each) do |example|
               login_as(user)
               patch :update, params: { id: event, ticket: @ticket_params } unless example.metadata[:skip_before]
            end

            it 'destroys the ticket', :skip_before do
               expect{ patch :update,
                       params: {
                         id: event,
                         ticket: @ticket_params
                       } }.to change(Ticket, :count).by(-1)
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
               patch :update, params: { id: event, ticket: @ticket_params } unless example.metadata[:skip_before]
            end

            it "doesn't destroy the ticket", :skip_before do
               expect{ patch :update,
                       params: {
                         id: event,
                         ticket: @ticket_params
                       } }.to change(Ticket, :count).by(0)
            end

            it_behaves_like('returning redirection response', '/login')
         end

         context 'with invalid or empty params' do
            before(:each) do |example|
               pending 'trying to build 404 page for activerecord error exception'
               login_as(user)
               @ticket_params[:'0'][:id] = nil
               patch :update, params: { id: event, ticket: @ticket_params }
            end
         end
      end
   end
end
