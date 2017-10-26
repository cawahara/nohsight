# frozen_string_literal: true

class BookmarksController < ApplicationController
   before_action :login_by_ajax
   before_action :set_event

   def update
      respond_to do |format|
         if current_user.assign_bookmark(@event)
            format.json { render json: current_user.bookmarked?(@event) }
         end
      end
   end

   def destroy
      respond_to do |format|
         if current_user.cancel_bookmark(@event)
            format.json { render json: current_user.bookmarked?(@event) }
         else
            format.json { render json: current_user.bookmarked?(@event) }
         end
      end
   end

   private

   def set_event
      @event = Event.find(params[:id])
   end
end
