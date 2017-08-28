require 'rails_helper'

RSpec.feature "FirstFunctions", type: :feature do
   include SpecTesthelper

   feature 'User creation' do
      given(:user_params) { attributes_for(:controller_user) }

      scenario 'New user is submitted' do
         visit('/')
         click_link('ログイン')

         expect(page).to have_content('ログイン情報入力')

         # 会員未登録の為ログイン不可能
         fill_in('email',     with: user_params[:email])
         fill_in('password',  with: user_params[:password])
         click_button('ログイン')

         expect(page).to have_selector('.flash-danger', text: '入力情報に不備があります')
         expect(page).to have_content('ログイン情報入力')

         # 新規会員登録(同時にログイン)
         click_link('会員登録はこちら')

         expect(page).to have_content('新規会員登録')
         expect{
            fill_in('name',                  with: user_params[:name])
            fill_in('email',                 with: user_params[:email])
            fill_in('information',           with: user_params[:information])
            fill_in('password',              with: user_params[:password])
            fill_in('password_confirmation', with: user_params[:password_confirmation])
            check('利用規約に同意する')
            click_button('新規登録する')
         }.to change(User, :count).by(1)
         expect(page).to have_selector('.flash-success', text: 'ユーザー登録が完了しました')
         expect(page).to have_content('最新の公演情報')

         # ログイン済みか確認
         expect(page).not_to have_content('ログイン')
      end

      scenario 'user logs in' do
         user = create(:controller_user)

         visit '/login'
         fill_in('email',     with: user.email)
         fill_in('password',  with: user.password)
         click_button('ログイン')

         expect(page).to have_selector('.flash-info', text: 'Noh-Event(仮)へようこそ！')
         expect(page).to have_content('最新の公演情報')
         expect(page).not_to have_content('ログイン')
      end
   end

   feature 'Showing event lists' do
      let(:event_params) { create(:first_search_event) }

      background do
         @user = create(:search_user)
         visit '/login'
         fill_in('email',     with: @user.email)
         fill_in('password',  with: @user.password)
         click_button('ログイン')

         # font-awesomeアイコンのみのボタンは下記の方法でクリックを再現
         find('#header-menu li:first-child').click
         expect(page).to have_selector('#dropdown-search')
      end

      scenario 'shows results in simple search', js: true do
         keywd_params = event_params.title[0..2]
         events = Event.where("title LIKE '%#{keywd_params}%'" )

         fill_in('easy_search_keywd', with: keywd_params)
         find('#dropdown-search button').click

         expect(page).to have_content("#{events.count}件の公演")
         expect(page).to have_selector('.article', count: events.count)
      end

      scenario 'shows results in detail search', js: true do
         start_date_params = event_params.start_date
         locations_params = event_params.place.title
         keywd_params = event_params.title[0..2]
         events = Event.where("title LIKE '%#{keywd_params}%'" )

         click_link('公演検索画面へ')

         expect(page).to have_content('公演検索')

         fill_in('start-date',   with: start_date_params)
         fill_in('locations',    with: start_date_params)
         fill_in('keywd',        with: keywd_params)
         click_button('検索する')

         expect(page).to have_content("#{events.count}件の公演")
         expect(page).to have_selector('.article', count: events.count)
      end

      scenario 'shows results associated to user' do
         events = @user.events
         # User個別のページに飛ぶ
         visit "/users/#{@user.id}"

         expect(page).to have_content("#{@user.name}")
         expect(page).to have_selector('.article', count: 3)

         # もっと見る
         find('.port-link').click

         expect(page).to have_content("#{events.count}件の公演")
         expect(page).to have_selector('.article', count: 5)
         expect(page).to have_selector('.pagination')
      end
   end

   feature 'Event Information' do
      given(:performer) { create(:controller_performer) }

      background do
         @user = create(:controller_user)
         @event = create(:controller_event)
         create(:controller_user_event, user: @user, event: @event)
         @ev_program = create(:controller_event_program, event: @event)
         @ev_performer = create(:controller_event_performer, event_program: @ev_program, performer: performer)
         @ticket = create(:controller_ticket, event: @event)

         visit '/login'
         fill_in('email',     with: @user.email)
         fill_in('password',  with: @user.password)
         click_button('ログイン')
      end

      scenario 'shows event overalls on listed page' do
         visit '/events'

         expect(page).to have_selector("#event-#{@event.id}")
         expect(page).to have_content("#{@event.title}")
         expect(page).to have_selector("#event-#{@event.id} .event-program", count: @event.event_programs.count)
         expect(page).to have_content("#{@ev_program.genre}")
         expect(page).to have_content("#{@ev_program.program.title}")
         expect(page).to have_selector("#event-#{@event.id} .event-performer", count: EventPerformer.where(event_program_id: @event.event_programs.ids).count)
         expect(page).to have_content("#{@ev_performer.performer.full_name}")
         expect(page).to have_selector("#event-#{@event.id} .ticket", count: @event.tickets.count)
         expect(page).to have_content("#{@ticket.grade}")
         expect(page).to have_content("#{@ticket.price}")
      end

      scenario 'shows event details' do
         visit "/events/#{@event.id}"

         # ヘッドライン
         expect(page).to have_content("#{@event.title}")
         expect(page).to have_content("#{@event.place.title}")
         expect(page).to have_content("#{@event.start_date.format_with_weekday}")

         expect(page).to have_selector('.organizer a', count: 1)
         expect(page).to have_content("#{@user.name} (登録者)")

         #イベント基本情報
         expect(page).to have_content('基本情報')
         expect(page).to have_content('演目と出演者')
         expect(page).to have_selector('.event-program', count: @event.event_programs.count)
         expect(page).to have_content("#{@ev_program.genre}")
         expect(page).to have_content("#{@ev_program.program.title}")
         expect(page).to have_selector('.event-performer', count: EventPerformer.where(event_program_id: @event.event_programs.ids).count)
         expect(page).to have_content("#{@ev_performer.performer.full_name}")

         expect(page).to have_content('開催時間')
<<<<<<< HEAD
         expect(page).to have_content("#{@event.open_date.format_with_hours}")
         expect(page).to have_content("#{@event.start_date.format_with_hours}")
=======
>>>>>>> 058d77df84cc9b9f56cf22b571fbb4797714e121

         expect(page).to have_content('チケット料金')
         expect(page).to have_selector('.ticket', count: @event.tickets.count)
         expect(page).to have_content("#{@ticket.grade}")
         expect(page).to have_content("#{@ticket.price}")

         expect(page).to have_content('公演詳細')
         expect(page).to have_content("#{@event.information}")

         expect(page).to have_content('公式サイト')
         expect(page).to have_content("#{@event.official_url}")

         expect(page).to have_content('会場案内')
         expect(page).to have_content("#{@event.place.address}")
         expect(page).to have_content("#{@event.place.official_url}")
         expect(page).to have_selector('.event-location')

         expect(page).to have_selector('.user-command')
         expect(page).to have_content('公演の編集')
      end
   end

   feature 'Creating events' do
   end
end
