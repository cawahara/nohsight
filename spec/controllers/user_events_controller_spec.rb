require 'rails_helper'

RSpec.describe UserEventsController, type: :controller do
   include SpecTesthelper

   describe 'POST #create' do
      let(:user) { create(:model_user) }
      let(:admin_event) { create(:admin_event) }

      context 'in a correct way' do
         before(:each) do
            login_as(user)
         end

         it 'creates a new user_event into the database' do
            expect{ post :create, id: admin_event }.to change(UserEvent, :count).by(1)
         end

         it 'is redirected to edit_port action' do
            post :create, id: admin_event
            expect(response).to redirect_to(edit_event_port_url(admin_event))
         end
      end

      context 'without login' do
         it 'create a new user_event' do
            expect{ post :create, id: admin_event }.to change(UserEvent, :count).by(0)
         end

         it 'is redirected to login action' do
            post :create, id: admin_event
            expect(response).to redirect_to(login_url)
         end
      end

      # TODO: 追加機能に応じてテストを追加する予定
      # TODO: 編集不可能というときの条件と処理をテスト
   end

   describe 'DELETE #destroy' do
      # TODO: 機能未実装の為コーディング未定
   end
end
