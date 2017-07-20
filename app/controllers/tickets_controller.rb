# frozen_string_literal: true

class TicketsController < ApplicationController
   before_action :is_logged_in?

   def edit
      @event = Event.find(params[:id])
      @tickets = @event.tickets
   end

   def update
      @event = Event.find(params[:id])
      @tickets = @event.tickets
      ticket_input = ticket_params
      ticket_input.each do |ticket_param|
         ticket_param = ticket_valid?(ticket_param)
         next if ticket_param == false
         flash['danger'] = '入力情報に不備があります'
         # FIXME: renderアクションに変え、どの箇所に不備があるかを表示できるようにする
         redirect_to(edit_ticket_url(@event)) && return
      end

      ticket_input.each do |ticket_param|
         case ticket_param['type']
         when 'update'
            ticket = Ticket.find(ticket_param['id'])
            ticket.update_attributes(grade: ticket_param['grade'],
                                     price: ticket_param['price'])
         when 'destroy'
            ticket = Ticket.find(ticket_param['id'])
            ticket.destroy
         when 'create'
            ticket = @event.tickets.build(grade: ticket_param['grade'],
                                          price: ticket_param['price'])
            ticket.save
         end
      end

      flash[:success] = '演目を変更しました'
      redirect_to(edit_event_port_url(@event))
   end

   private

   def ticket_params
      tickets_hash = params.require(:ticket).permit!
      tickets_array = []
      tickets_hash.each do |value|
         tickets_array << value
      end

      return tickets_array
   end

   def ticket_valid?(ticket_param)
      if ticket_param['type'] == 'create' || ticket_param['type'] == 'update'
         return false if ticket_param['grade'].empty? || ticket_param['price'].empty?
         return false if /[^0-9]+/.match?(ticket_param['price'])
      end

      return ticket_param
   end
end
