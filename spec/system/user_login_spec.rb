require 'rails_helper'

RSpec.feature 'UserLogin', type: :system do

    let(:user) { create(:controller_user) }

    background do
      visit('/login')
      expect(page).to have_selector('div#sessions-new')
    end

    # 正常系：ユーザのログイン、ログアウト
    scenario "logs in and accesses logged user's pages (as long as logs out)" do

      fill_in('email', with: user.email)
      fill_in('password', with: user.password)
      click_button('login-btn')

      # rootにredirectしたか確認
      expect(page).to have_selector('div#dashboard')

      # ログインできたか確認
      expect(page).not_to have_selector('li#login-btn')

      # users#show(ログインユーザ)にアクセスできるか確認
      page.find('#header-menu > ul > li.header-btn:nth-child(1)').click
      page.find('#dropdown-nav > li:nth-child(1)').click

      expect(page).to have_selector('div#users-show')

      # bookmarks#indexにアクセスできるか確認
      page.find('#header-menu > ul > li.header-btn:nth-child(1)').click
      page.find('#dropdown-nav > li:nth-child(2)').click

      expect(page).to have_selector('div#bookmarks-index')

      # join_histories#indexにアクセスできるか確認
      page.find('#global-nav > li:nth-child(2) > a').click

      expect(page).to have_selector('div#join-histories-index')

      # events#manageにアクセスできるか確認
      page.find('#global-nav > li:nth-child(3) > a').click

      expect(page).to have_selector('div#events-manage')

      # bookmarks#indexにアクセスできるか確認(ヘッダー以外で)
      page.find('#global-nav > li:nth-child(1) > a').click

      expect(page).to have_selector('div#bookmarks-index')

      # ログアウトできたか確認
      page.find('#header-menu > ul > li.header-btn:nth-child(1)').click
      page.find('#dropdown-nav > li:nth-child(4)').click

      expect(page).to have_selector('div#sessions-new')
      expect(page).to have_selector('li#login-btn')
    end

    # 異常系：ログイン失敗
    scenario "can't log in" do

      fill_in('email', with: '')
      fill_in('password', with: user.password)
      click_button('login-btn')

      # ログインされてないか確認
      expect(page).to have_selector('div#sessions-new')
      expect(page).to have_selector('li#login-btn')

      expect(page).to have_field('email', with: '')

      # パスワード未入力でも同様の動きになるか確認
      fill_in('email', with: user.email)
      fill_in('password', with: '')
      click_button('login-btn')

      expect(page).to have_selector('div#sessions-new')
      expect(page).to have_selector('li#login-btn')

      expect(page).to have_field('email', with: user.email)
    end
end
