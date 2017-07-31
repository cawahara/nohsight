require 'rails_helper'

RSpec.describe ProgramsController, type: :controller do
   include SpecTesthelper

   let(:user) { create(:model_user) }

   describe 'GET #index' do
      context 'when logged user accesses' do
         before(:each) do
            login_as(user)
            get :index
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without log in' do
         it 'is redirected to login action' do
            get :index
            expect(response).to redirect_to(login_url)
         end
      end
   end

   describe 'GET #show' do
      let(:program) { create(:model_program) }
      context 'when login with program param' do
         before(:each) do
            login_as(user)
            get :show, id: program
         end
         it 'assigns targeted program' do
            expect(assigns(:program)).to eq(program)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :show, id: program
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without program param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :show }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'GET #new' do
      context 'when logged user accesses' do
         before(:each) do
            login_as(user)
            get :new
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without log in' do
         it 'is redirected to login action' do
            get :new
            expect(response).to redirect_to(login_url)
         end
      end
   end

   describe 'GET #edit' do
      let(:program) { create(:model_program) }
      context 'when login with program param' do
         before(:each) do
            login_as(user)
            get :edit, id: program
         end
         it 'assigns targeted program' do
            expect(assigns(:program)).to eq(program)
         end

         it 'returns response status with 200' do
            expect(response.status).to eq(200)
         end
      end

      context 'without login' do
         it 'is redirected to login action' do
            get :edit, id: program
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without program param' do
         it 'occurs an error' do
            login_as(user)
            expect{ get :edit }.to raise_error(ActionController::UrlGenerationError)
         end
      end
   end

   describe 'POST #create' do
      let(:program_params) { attributes_for(:model_program) }

      context 'when login with valid params' do
         before(:each) do
            login_as(user)
         end

         it 'creates a new program into the database' do
            expect{ post :create, program: program_params }.to change(Program, :count).by(1)
         end

         it 'is redirected to show action' do
            post :create, program: program_params
            expect(response).to redirect_to(program_url(program))
         end
      end

      context 'without login' do
         it "doesn't creates a new program" do
            expect{ post :create, program: program_params }.to change(Program, :count).by(0)
         end

         it 'is redirected to login action' do
            post :create, program: program_params
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without valid params' do
         before(:each) do
            login_as(user)
            program_params['title'] = nil
         end

         it 'creates a new program into the database' do
            expect{ post :create, program: program_params }.to change(Program, :count).by(0)
         end

         it 'renders new template' do
            post :create, program: program_params
            expect(response).to render_template(:new)
         end
      end
   end

   describe 'PATCH #update' do
      let(:program) { create(:model_program) }
      let(:program_params) { attributes_for(:diff_program) }

      context 'when login with valid params' do
         before(:each) do
            login_as(user)
            post :update, id: program, program: program_params
         end

         it 'updates program attributes' do
            program.reload
            expect(program.title).to eq('Different Program')
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(program_url(program))
         end
      end

      context 'without login' do
         before(:each) do
            post :update, id: program, program: program_params
         end

         it "doesn't update the program" do
            program.reload
            expect(program.title).not_to eq('Different Program')
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end

      context 'without valid params' do
         before(:each) do
            login_as(user)
            program_params['title'] = nil
            post :update, id: program, program: program_params
         end

         it 'creates a new program into the database' do
            program.reload
            expect(program.title).not_to eq('Different Program')
         end

         it 'renders new template' do
            expect(response).to render_template(:edit)
         end
      end
   end

   describe 'DELETE #destroy' do
      let!(:program) { create(:model_program) }
      let!(:diff_program) { create(:diff_program) }
      context 'when login with valid params' do
         before(:each) do
            login_as(user)
         end

         it 'destroys the program' do
            expect{ delete :create, id: program }.to change(Program, :count).by(-1)
         end

         it 'is redirected to index action' do
            expect(response).to redirect_to(programs_url)
         end
      end
      context 'without login' do
         it "doesn't destroy the program" do
            expect{ delete :create, id: program }.to change(Program, :count).by(0)
         end

         it 'is redirected to login action' do
            expect(response).to redirect_to(login_url)
         end
      end
      context 'when trying to destroy deleted program' do
         before(:each) do
            login_as(user)
            diff_program.destroy
         end

         it "doesn't destroy the program" do
            expect{ delete :destroy, id: diff_program }.to change(Program, :count).by(0)
         end

         it 'is redirected to show action' do
            expect(response).to redirect_to(program_url(program))
         end
      end
   end
end
