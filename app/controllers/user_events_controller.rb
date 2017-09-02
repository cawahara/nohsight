# frozen_string_literal: true

class UserEventsController < ApplicationController
   before_action :logged_in?

   def create
      @event = Event.find(params[:id])
      @user_event = current_user.user_events.build(params_for_create)
      if @user_event.save
         flash[:success] = '新たな公演編集メンバーになりました'
         redirect_to(edit_event_port_url(@event))
      else
         flash[:danger] = '編集不可能です'
         redirect_to(event_url(@event))
      end
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
