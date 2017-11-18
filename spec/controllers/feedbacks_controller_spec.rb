require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do
   include SpecTesthelper

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

   describe 'GET #new' do
      context 'accessing normally' do
         it 'assigns @email as empty value' do
            expect(assigns(:email)).to be_nil
         end

         it 'assigns @content as empty value' do
            expect(assigns(:content)).to be_nil
         end

         it_behaves_like('returning success response', false)
      end
   end

   describe 'POST #create' do
      let(:user_params) { attributes_for(:controller_user) }

      context 'with valid params' do
         before(:each) do |example|
            post :create, feedback: { email: user_params[:email], content: 'feedback comment' } unless example.metadata[:skip_before]
         end

         it 'assigns @email' do
            expect(assigns(:email)).to eq(user_params[:email])
         end

         it 'assigns @content' do
            expect(assigns(:content)).to eq('feedback comment')
         end

         it 'send feedback email', :skip_before do
            expect{ post :create, feedback: { email: user_params[:email], content: 'feedback comment' } }.to change{ ActionMailer::Base.deliveries.size }.by(1)
         end

         it_behaves_like('returning redirection response', '/')
      end

      context 'with invalid email params' do
         before(:each) do |example|
            post :create, feedback: { email: '', content: 'feedback comment' } unless example.metadata[:skip_before]
         end

         it "doesn't send feedback email", :skip_before do
            expect{ post :create, feedback: { email: '', content: 'feedback comment' } }.to change{ ActionMailer::Base.deliveries.size }.by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end

      context 'with empty content params' do
         before(:each) do |example|
            post :create, feedback: { email: user_params[:email], content: '' } unless example.metadata[:skip_before]
         end

         it "doesn't send feedback email", :skip_before do
            expect{ post :create, feedback: { email: user_params[:email], content: '' } }.to change{ ActionMailer::Base.deliveries.size }.by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end
   end
end
