require 'rails_helper'

RSpec.feature 'UserRegistration', type: :system do
  include SpecTesthelper
  include EmailSpec::Helpers
  include EmailSpec::Matchers

    let(:user_params) { attributes_for(:controller_user) }

    background do
      visit('/users/new')
      expect(page).to have_selector('div#users-new')
    end

    # 正常系：ユーザ登録
    scenario 'registers a new user with completely filled values' do

      expect{
        fill_in('name', with: user_params[:name])
        fill_in('email', with: user_params[:email])
        fill_in('information', with: user_params[:information])
        fill_in('password', with: user_params[:password])
        fill_in('password_confirmation', with: user_params[:password_confirmation])
        check('agreement')
        click_button('submit-user')
      }.to change(User, :count).by(1)

      expect(User.last.confirmed).to eq(false)

      # rootにredirectしたか確認
      expect(page).to have_selector('div#dashboard')

      # 仮登録の為ログインは不可能
      expect(page).to have_selector('li#login-btn')

      # 本登録メールのご案内
      open_email(user_params[:email])
      link = current_email.parts[0].body.match(/\/confirmation\/.*/).to_s
      visit link

      expect(User.last.confirmed).to eq(true)

      # Userページにredirectしたか確認
      expect(page).to have_selector('div#users-show')

      # ログイン済みか確認
      expect(page).not_to have_selector('li#login-btn')
    end

    # 異常系：ユーザ登録失敗
    scenario "doesn't register a new user without required values" do

      # 初期値を入力し、一つずつ値をinvalidにする
      fill_in('name', with: user_params[:name])
      fill_in('email', with: user_params[:email])
      fill_in('information', with: user_params[:information])
      fill_in('password', with: user_params[:password])
      fill_in('password_confirmation', with: user_params[:password_confirmation])
      check('agreement')

      expect{
        fill_in('name', with: '')
        click_button('submit-user')
      }.to change(User, :count).by(0)

      # 入力情報に不備があるので入力画面に戻される
      expect(page).to have_selector('div#users-new')

      expect(page).to have_field('name', with: '')
      expect(page).to have_field('email', with: user_params[:email])
      expect(page).to have_field('information', with: user_params[:information])

      # 最初のexpectationsが正しければ、後はUserがcreateされたかどうかだけ確認すればよい
      expect{
        fill_in('email', with: '')
        click_button('submit-user')
      }.to change(User, :count).by(0)

      expect{
        fill_in('password', with: '')
        click_button('submit-user')
      }.to change(User, :count).by(0)

      expect{
        fill_in('password_confirmation', with: '')
        click_button('submit-user')
      }.to change(User, :count).by(0)

      expect{
        uncheck('agreement')
        click_button('submit-user')
      }.to change(User, :count).by(0)
    end
end
