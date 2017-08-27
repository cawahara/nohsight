require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

   shared_examples 'returning success response' do
      it { expect(response).to have_http_status(200) }
   end

   describe 'GET #dashboard' do
      let!(:user) { create(:controller_user, :start_from_this) }
      context 'accessing normally' do
         before(:each) do
            get :dashboard
         end

         it 'assigns @events' do
            expect(assigns(:events)).to eq(user.events)
         end

         it 'returns number of events' do
            expect(assigns(:events).count).to eq(user.events.count)
         end

         it_behaves_like('returning success response')
      end
   end

   describe 'GET #search' do
      context 'accessing normally' do
         before(:each) do
            get :search
         end

         it_behaves_like('returning success response')
      end
   end

   describe 'GET #about' do
      context 'accessing normally' do
         before(:each) do
            get :about
         end

         it_behaves_like('returning success response')
      end
   end

   describe 'GET #help' do
      context 'accessing normally' do
         before(:each) do
            get :help
         end

         it_behaves_like('returning success response')
      end
   end

   describe 'GET #convention' do
      context 'accessing normally' do
         before(:each) do
            get :convention
         end

         it_behaves_like('returning success response')
      end
   end
end
