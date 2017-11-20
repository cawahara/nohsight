# frozen_string_literal: true

class BookmarksController < ApplicationController
   before_action :logged_in?,    only: [:index]
   before_action :login_by_ajax, only: [:update, :destroy]
   before_action :set_event,     only: [:update, :destroy]
   before_action :change_finished_join_status, only: [:index]

   def index
      @events = current_user.bookmark_events
   end

   def update
      respond_to do |format|
         current_user.assign_bookmark(@event)
         format.json { render json: bookmark_json }
      end
   end

   def destroy
      respond_to do |format|
         current_user.cancel_bookmark(@event) if current_user.bookmarked?(@event)
         format.json { render json: bookmark_json }
      end
   end

   private

   def set_event
      @event = Event.find(params[:id])
   end

   def bookmark_json
      return { bookmarked: current_user.bookmarked?(@event),
               count: @event.bookmarks.count }
   end
end
