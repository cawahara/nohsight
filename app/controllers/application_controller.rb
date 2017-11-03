# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class ApplicationController < ActionController::Base
   protect_from_forgery with: :null_session
   include UsersHelper
   include EventsHelper
   include PerformersHelper
   include SessionsHelper

   def logged_in?
      unless logged?
         flash[:danger] = 'ログインが必要です'
         redirect_to(login_url)
      end
   end

   def logged_user?
      unless params[:id].to_i == current_user.id
         flash['danger'] = '他ユーザへの編集は制限されています'
         redirect_back_or(root_url)
      end
      return true
      # REVIEW: 釈然としない(def最下層到達時に自動でreturn trueするが
      #         書かないとrubocopが検出してしまう)
   end

   def login_by_ajax
      if params[:user_id]
         login(User.find(params[:user_id]))
      else
         flash[:danger] = 'ログインが必要です'
         redirect_to(login_url)
      end
   end

   def event_editor?
      event = Event.find(params[:id])
      unless event.user_events.find_by(user_id: current_user.id)
         flash['danger'] = '主催者ではないユーザの編集は制限されています。'
         redirect_back_or(root_url)
      end
      return true
   end
end
