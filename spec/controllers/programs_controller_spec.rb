require 'rails_helper'

RSpec.describe ProgramsController, type: :controller do
   include SpecTesthelper

   let(:user) { create(:controller_user) }

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
      context 'when logged user accesses' do
      end
      context 'without log in' do
      end
   end

   describe 'GET #show' do
      let(:program) { create(:controller_program, :program_show_action) }

      context 'with program params' do
         before(:each) do
            login_as(user)
            @events = program.events.limit(3)
            get :show, params: { id: program }
         end

         it 'assigns @program' do
            expect(assigns(:program)).to eq(program)
         end

         it 'gets 3 events' do
            expect(assigns(:events).count).to eq(3)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without login' do
         before(:each) do
            get :show, params: {
id: program
}
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'without program params' do
         before(:each) do
            login_as(user)
         end

         it_behaves_like('occurs an error', 'show')
      end
   end

   describe 'GET #new' do
      context 'accessing normally' do
         before(:each) do
            login_as(user)
            get :new
         end

         it 'assigns @program as a new' do
            expect(assigns(:program)).to be_a_new(Program)
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

   describe 'GET #edit' do
      let(:program) { create(:controller_program) }

      context 'with program params' do
         before(:each) do
            login_as(user)
            get :edit, params: { id: program }
         end

         it 'assigns @program' do
            expect(assigns(:program)).to eq(program)
         end

         it_behaves_like('returning success response', false)
      end

      context 'without login' do
         before(:each) do
            get :edit, params: { id: program }
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'without program params' do
         before(:each) do
            login_as(user)
         end

         it_behaves_like('occurs an error', 'edit')
      end
   end

   describe 'POST #create' do
      context 'with valid params' do
         let(:program_params) { attributes_for(:controller_program) }
         before(:each) do |example|
            login_as(user)
            post :create, params: { program: program_params } unless example.metadata[:skip_before]
         end

         it 'assigns @program as a created one' do
            expect(assigns(:program)).to be_persisted
         end

         it 'creates a new program into the database', :skip_before do
            expect{ post :create, params: {
program: program_params
} }.to change(Program, :count).by(1)
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirect_to show action' do
            expect(response).to redirect_to(program_url(assigns(:program)))
         end
      end
      context 'without login' do
         let(:program_params) { attributes_for(:controller_program) }
         before(:each) do |example|
            post :create, params: {
program: program_params
} unless example.metadata[:skip_before]
         end

         it "doesn't create a program", :skip_before do
            expect{ post :create, params: { program: program_params } }.to change(Program, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with invalid params' do
         let(:program_params) { attributes_for(:controller_program, :invalid_params) }
         before(:each) do |example|
            login_as(user)
            post :create, params: { program: program_params } unless example.metadata[:skip_before]
         end

         it "doesn't create a program", :skip_before do
            expect{ post :create, params: { program: program_params } }.to change(Program, :count).by(0)
         end

         it_behaves_like('returning success response', true, 'new')
      end
   end

   describe 'PATCH #update' do
      let(:program) { create(:controller_program) }

      context 'with valid params' do
         before(:each) do
            login_as(user)
            patch :update, params: { id: program, program: attributes_for(:controller_program, title: 'Changed Title') }
         end

         it 'changes program attributes' do
            program.reload
            expect(program.title).to eq('Changed Title')
         end

         it "returns response status 302" do
            expect(response).to have_http_status(302)
         end

         it 'is redirect_to show action' do
            expect(response).to redirect_to(program_url(assigns(:program)))
         end
      end

      context 'without login' do
         before(:each) do
            patch :update, params: { id: program, program: attributes_for(:controller_program, title: 'Changed Title') }
         end

         it "doesn't change program attributes" do
            program.reload
            expect(program.title).not_to eq('Changed Title')
         end

         it_behaves_like('returning redirection response', '/login')
      end

      context 'with invalid param' do
         before(:each) do
            login_as(user)
            patch :update, params: {
  id: program,
  program: attributes_for(:controller_program, title: '')
}
         end

         it "doesn't change program attributes" do
            program.reload
            expect(program.title).not_to eq('')
         end

         it_behaves_like('returning success response', true, 'edit')
      end
   end

   describe 'DELETE #destroy' do
      let!(:program) { create(:controller_program) }

      context 'with valid program params' do
         before(:each) do |example|
            login_as(user)
            delete :destroy, params: {
id: program
} unless example.metadata[:skip_before]
         end

         it 'destroys program', :skip_before do
            expect{ delete :destroy, params: { id: program } }.to change(Program, :count).by(-1)
         end

         it_behaves_like('returning redirection response', '/programs')
      end

      context 'without login' do
         before(:each) do |example|
             delete :destroy, params: { id: program } unless example.metadata[:skip_before]
         end

         it "doesn't destroy program", :skip_before do
            expect{ delete :destroy, params: { id: program } }.to change(Program, :count).by(0)
         end

         it_behaves_like('returning redirection response', '/login')
      end
   end
end
