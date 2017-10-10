# frozen_string_literal: true

class UserEventsController < ApplicationController
   include SetVariablesOnEventsController

   before_action :logged_in?

   def create
      @event = Event.find(params[:id])
      flash[:success] = '新たな公演編集メンバーになりました'
      values_on_edit('create')
      render 'events/new'
   end

   def destroy
      # TODO: 実装未定
   end

   private

   def params_for_create
      return { user_id: current_user.id,
               event_id: params[:id],
               organizer: false }
   end
end
