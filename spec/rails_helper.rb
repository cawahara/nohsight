# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'factory_girl'
require 'email_spec'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|

  # Execute system spec mode in a headless mode
  config.before(:each) do |example|
    if example.metadata[:type] == :system
      driven_by :selenium_chrome_headless, screen_size: [1400, 1400]
    end
  end
   config.include(FactoryGirl::Syntax::Methods)
   config.infer_spec_type_from_file_location!

   config.filter_rails_from_backtrace!
   config.include EmailSpec::Helpers
   config.include EmailSpec::Matchers

   config.use_transactional_fixtures = false
   require 'database_cleaner'
   config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean_with(:truncation)
   end

   config.before(:each) do
      DatabaseCleaner.start
   end

   config.after(:each) do
      DatabaseCleaner.clean
   end
end
