# frozen_string_literal: true

class TicketsController < ApplicationController
   include UpdateEventAssociations
   before_action :is_logged_in?

   def edit
      @event = Event.find(params[:id])
      @tickets = @event.tickets
   end

   def update
      @event = Event.find(params[:id])
      @tickets = @event.tickets
      ticket_input = multiple_params('ticket')
      ticket_input = params_valid?(ticket_input, '', '', '')
      if ticket_input == false
         flash['danger'] = '入力情報に不備があります'
         # FIXME: renderアクションに変え、どの箇所に不備があるかを表示できるようにする
         redirect_to(edit_ticket_url(@event)) && return
      end

      update_with_params(ticket_input, ['grade', 'price'], Ticket, @event.tickets)

      flash[:success] = '演目を変更しました'
      redirect_to(edit_event_port_url(@event))
   end
end
