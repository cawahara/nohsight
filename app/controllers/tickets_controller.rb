class TicketsController < ApplicationController
  def edit
     @event = Event.find(params[:id])
     @tickets = @event.tickets
     respond_to do |format|
        format.html
        format.json { render json: {
                                    event:     @event,
                                    tickets:   @tickets
                                    } }
     end
  end


  def update
     @event = Event.find(params[:id])
     @tickets = @event.tickets
     ticket_input = ticket_params
     ticket_input.each do |ticket_param|
        ticket_param = ticket_valid?(ticket_param)
        if ticket_param == false
           flash['danger'] = "入力情報に不備があります"
           # FIXME renderアクションに変え、どの箇所に不備があるかを表示できるようにする
           redirect_to(edit_ticket_url(@event)) and return
        end
     end

     ticket_input.each do |ticket_param|
        case ticket_param['type']
        when 'update'
           ticket = Ticket.find(ticket_param['id'])
           ticket.update_attributes(
                                    grade:  ticket_param['grade'],
                                    price:  ticket_param['price']
                                    )
        when 'destroy'
           ticket = Ticket.find(ticket_param['id'])
           ticket.destroy
        when 'create'
           ticket = @event.tickets.build(
                                    grade:  ticket_param['grade'],
                                    price:  ticket_param['price']
                                    )
            ticket.save
        end
     end

     flash[:success] = "演目を変更しました"
     redirect_to(edit_port_event_url(@event))
  end


  private

      def ticket_params
         tickets_hash = params.require(:ticket).permit!
         tickets_array = []
         tickets_hash.each do |key, value|
            tickets_array << value
         end

         return tickets_array
      end

      def ticket_valid?(ticket_param)
         if ticket_param['type'] == 'create' || ticket_param['type'] == 'update'
            if ticket_param['grade'].empty? || ticket_param['price'].empty?
               return false
            elsif /[^0-9]+/ =~ ticket_param['price']
               return false
            end
         end

         return ticket_param
      end
end
