# frozen_string_literal: true

class BookmarksController < ApplicationController
   before_action :login_by_ajax
   before_action :set_event

   def update
      respond_to do |format|
         if current_user.assign_bookmark(@event)
            format.json { render json: bookmark_json }
         end
      end
   end

   def destroy
      respond_to do |format|
         if current_user.cancel_bookmark(@event)
            format.json { render json: bookmark_json }
         else
            format.json { render json: bookmark_json }
         end
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
