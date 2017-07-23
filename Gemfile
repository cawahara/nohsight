source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# デフォルトで配備してあるgem群
gem 'rails',                   '~> 5.0.2'
gem 'puma',                    '~> 3.0'
gem 'sass-rails',              '~> 5.0'
gem 'uglifier',                '~> 2.6.1'
gem 'coffee-rails',            '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks',              '~> 5'
gem 'jbuilder',                '~> 2.5'
gem 'seed-fu',                 '~> 2.3'                     # seed.rbをより扱いやすく(主にidの割り振りによる管理？)
gem 'font-awesome-rails',      '~> 4.7'                     # font-awesomeを扱うヘルパー
gem 'carrierwave',             '~> 0.11.2'                  # 画像アップロード用ヘルパー
gem 'simple_enum',             '~> 2.3'                     # enumqを扱うヘルパー
gem 'kaminari'                                              # paginateヘルパー
gem 'bcrypt',                  '~> 3.1.7'                   # 文字列(主にパスワード)のハッシュ化
gem 'ransack',                 '~> 1.8'                     # ActiveREcordのレコード検索用ヘルパー
gem 'seed_dump',               '>= 3.2.4'                   # データベース内レコードをseedに移行
gem 'bootstrap-sass'                                        # bootstrap
gem 'webpacker',               '~> 2.0'                     # WebPackをRailsで
gem 'dotenv-rails',            '>= 2.2.1'                   # rails内に環境変数導入
gem 'mysql2',                  '~> 0.4.4'                   # 管理データベースをMySQLに移行
# gem 'redis', '~> 3.0'
gem 'therubyracer', platforms: :ruby
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Add for debug (change from default gem: byebug)
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rack-cors', :require => 'rack/cors'
  gem 'rubocop', '~> 0.47.1'
  gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'capybara', '~> 2.7', '>= 2.7.1'
end

group :development do
  # デフォルトで配備
  gem 'web-console',             '>= 3.3.0'
  gem 'listen',                  '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen',   '~> 2.0.0'
end

group :test do
   # 後から追加
   gem 'rails-controller-testing',    '0.1.1'            # assigns関数の追加
   gem 'minitest-reporters',          '~> 1.1.9'         # テスト結果をプログレスバーで表示
   gem 'timecop'                                         # テスト環境で時間操作
end

# デフォルトで配備
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
