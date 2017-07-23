# frozen_string_literal: true
require 'net/http'
require 'uri'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include EventsHelper
  include EventProgramsHelper
  include SessionsHelper

  def is_logged_in?
     redirect_to(login_url) unless is_logged?
  end

  def is_logged_user?
     unless params[:id].to_i == current_user.id
        flash['danger'] = '他ユーザの編集は制限されています'
        redirect_back_or(root_url)
     end
  end
end
