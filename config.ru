# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application
require 'rack/cors'

use Rack::Cors do
   # TODO: 必要なくなったので消します
  # allow all origins in development
  allow do
    origins '*'
    resource '*', :headers => :any, :methods => [:get, :post, :put, :options, :delete], :credentials => false
  end
end
