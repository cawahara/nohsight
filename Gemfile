# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
   repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
   "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

# デフォルトで配備してあるgem群
gem 'bcrypt', '~> 3.1.7' # 文字列(主にパスワード)のハッシュ化
gem 'bootstrap-sass' # bootstrap
gem 'carrierwave', git: 'https://github.com/carrierwaveuploader/carrierwave.git' # 画像アップロード用ヘルパー
gem 'coffee-rails', '~> 4.2'
gem 'dotenv-rails', '>= 2.2.1' # rails内に環境変数導入
gem 'font-awesome-rails', '~> 4.7' # font-awesomeを扱うヘルパー
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'kaminari'                                              # paginateヘルパー
gem 'puma',                    '~> 3.0'
gem 'rails',                   '~> 5.0.2'
gem 'ransack',                 '~> 1.8'                     # ActiveRecordのレコード検索用ヘルパー
gem 'sass-rails',              '~> 5.0'
gem 'seed-fu',                 '~> 2.3'                     # seed.rbをより扱いやすく(主にidの割り振りによる管理？)
gem 'seed_dump',               '>= 3.2.4'                   # データベース内レコードをseedに移行
gem 'simple_enum',             '~> 2.3'                     # enumqを扱うヘルパー
gem 'turbolinks',              '~> 5'
gem 'uglifier',                '~> 2.6.1'
gem 'webpacker',               '~> 2.0'                     # WebPackをRailsで
gem 'deep_cloneable', '~> 2.3', '>= 2.3.1'                  # nestedしたassociationsもまとめてrecordをdup
gem 'pg'                                                    # sql環境をpostgresqlに変更
# gem 'redis', '~> 3.0'
gem 'therubyracer', platforms: :ruby
gem 'spring-commands-rspec'
gem 'simplecov', '~> 0.15.1'
gem 'rmagick', '~> 2.15', '>= 2.15.4'
gem 'cloudinary', '~> 1.2', '>= 1.2.2'
gem 'mechanize', '~> 2.7', '>= 2.7.5'                       # スクレイピングを直感的に使えるヘルパー
# gem 'capistrano-rails', group: :development

group :development, :test do
   # Add for debug (change from default gem: byebug)
   gem 'factory_bot_rails'
   gem 'pry-byebug'
   gem 'pry-rails'
   gem 'rack-cors', require: 'rack/cors'
   gem 'rspec-rails', '~> 3.4', '>= 3.4.2'
   gem 'rubocop', '~> 0.47.1'
end

group :development do
   # デフォルトで配備
   gem 'listen', '~> 3.0.5'
   gem 'spring'
   gem 'spring-watcher-listen', '~> 2.0.0'
   gem 'web-console', '>= 3.3.0'
end

group :test do
   # 後から追加
   gem 'minitest-reporters',          '~> 1.1.9'         # テスト結果をプログレスバーで表示
   gem 'rails-controller-testing',    '0.1.1'            # assigns関数の追加
   gem 'timecop'                                         # テスト環境で時間操作
   gem 'poltergeist', '~> 1.10'
   gem 'capybara', '~> 2.7', '>= 2.7.1'
   gem 'database_cleaner'
   gem 'selenium-webdriver'
end

group :production do
   gem 'rails_12factor'
end

# デフォルトで配備
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
