require 'rails_helper'

RSpec.describe UserEventsController, type: :controller do
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

   describe 'POST #create' do
      let(:user) { create(:controller_user) }
      let(:diff_event) { create(:different_event, :start_from_this) }

      context 'with event params' do
         before(:each) do
            login_as(user)
            post :create, params: { id: diff_event }
            @event = diff_event
            @place = diff_event.place
            @event_program = diff_event.event_programs.first
            @event_performer = @event_program.event_performers.first
            @ticket = diff_event.tickets.first
         end

         it 'assigns @event' do
            expect(assigns(:event)).to eq(diff_event)
         end

         it 'renders events#new template' do
            expect(response).to render_template('events/new')
         end

         it 'returns event_params which has values of event' do
            expect(assigns(:event_params)[:id]).to eq(@event.id)
         end

         it 'returns places_params which has values of places' do
            expect(assigns(:place_params)[:title]).to eq(@place.title)
         end

         it 'returns event_programs_params which has values of event_program' do
            expect(assigns(:event_programs_params)[:'0'][:id]).to eq(@event_program.id)
         end

         it 'returns event_performers_params which has values of event_performer' do
            expect(assigns(:event_programs_params)[:'0'][:event_performers][:'0'][:id]).to eq(@event_performer.id)
         end

         it 'returns tickets_params which has values of ticket' do
            expect(assigns(:tickets_params)[:'0'][:id]).to eq(@ticket.id)
         end
      end

      context 'without login' do
         before(:each) do
            post :create, params: { id: diff_event }
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'without event params' do
         before(:each) do
            login_as(user)
         end

         it 'occurs ActionController::UrlGenerationError' do
            expect{ post :create }.to raise_error(ActionController::UrlGenerationError)
         end

         it 'returns status code 404' do
            pending "it needs to get response status 404 from its controller and relative view"
            post :create
            expect(response).to have_http_status(404)
         end
      end
   end

   describe 'DELETE #destroy' do
      # REVIEW: 機能未実装の為コーディング未定
   end
end
