# frozen_string_literal: true

require 'net/http'
require 'uri'
require 'json'

class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
   include EventsHelper
   include EventProgramsHelper
   include SessionsHelper

   def logged_in?
      redirect_to(login_url) unless logged?
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

   def event_editor?
      event = Event.find(params[:id])
      unless event.user_events.find_by(user_id: current_user.id)
         flash['danger'] = '主催者ではないユーザの編集は制限されています。'
         redirect_back_or(root_url)
      end
      return true
   end
end
