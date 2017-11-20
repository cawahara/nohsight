# frozen_string_literal: true

class JoinHistoriesController < ApplicationController
   before_action :logged_in?,    only: [:index]
   before_action :login_by_ajax, only: [:update, :destroy]
   before_action :set_event,     only: [:update, :destroy]
   before_action :change_finished_join_status, only: [:index]

   def index
      @events = current_user.bookmark_events
   end

   def update
      respond_to do |format|
         current_user.assign_join_history(@event)
         format.json { render json: join_history_json }
      end
   end

   def destroy
      respond_to do |format|
         current_user.cancel_join_history(@event) if current_user.join_status(@event) != false
         format.json { render json: join_history_json }
      end
   end

   private

   def set_event
      @event = Event.find(params[:id])
   end

   def join_history_json
      return { status: current_user.join_status(@event) }
   end
end
