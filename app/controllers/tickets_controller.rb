# frozen_string_literal: true

class TicketsController < ApplicationController
   include UpdateEventAssociations
   before_action :logged_in?
   before_action :set_variables

   def edit
   end

   def update
      tickets = get_params('ticket')
      tickets = update_bundled_records(tickets, Ticket, '', '', '')
      if tickets == true
         flash[:success] = '演目を変更しました'
         redirect_to(edit_event_port_url(@event))
      else
         flash.now['danger'] = '赤枠の項目内の入力情報に不備があります'
         render 'tickets/edit'
      end
   end

   private

   def set_variables
      @event = Event.find(params[:id])
      @tickets = @event.tickets

      @render_params = params if params[:ticket]
   end
end
