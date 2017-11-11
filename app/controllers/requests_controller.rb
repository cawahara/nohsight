class RequestsController < ApplicationController
   before_action :logged_in?
   before_action :only_admin
   before_action :set_event, only: [:show, :update]

   def index
      @events = Event.where(publishing_status: 1)
   end

   def show
      if @event.publishing_status != 1
         flash.now[:danger] = 'この公演情報は承認リクエストされておりません。'
         redirect_to requests_url
      end
      @comment = Comment.new
   end

   def update
      response_params
      begin
         ActiveRecord::Base.transaction do
            if @response_params[:approved] == '2'
               update_comment
               @event.update_attributes!(publishing_status: 2)
               raise ActiveRecord::RecordInvalid if update_comment == false
               flash[:warning] = '公演情報の公開リクエストを却下しました。'
            else
               merge_events
               flash[:success] = '公演情報の公開リクエストを承認しました。'
            end
            redirect_to requests_url
         end
      rescue ActiveRecord::RecordInvalid
         flash[:danger] = '入力情報に不備があります。'
         render 'requests/show'
      end
   end

   private

   def set_event
      @event = Event.find(params[:id])
   end

   def only_admin
      unless admin_user?
         flash[:danger] = '運営以外のアクセスは禁止されています。'
         redirect_to root_url
      end
   end

   def response_params
      @response_params = params.require(:approval).permit(:approved, :comment)
   end

   def update_comment
      @comment = @event.comment
      if @comment
         @comment.content = @response_params[:comment]
      else
         @comment = @event.build_comment(user: current_user, content: @response_params[:comment])
      end
      return @comment.save ? true : false
   end

   def merge_events
      if @event.original
         original_event = @event.original
         original_event.attributes = @event.attributes

         original_event.update_attributes({ id: @event.original_event_id, original_event_id: nil, publishing_status: 3 })
         original_event.remove_flyers!
         original_event.flyers = @event.flyers
         original_event.save
         re_create_associations(original_event)
         @event.approve_edition_event
      else
         @event.approve_original_event
      end
   end

   def re_create_associations(original_event)
      original_event.event_programs.delete_all
      original_event.tickets.delete_all
      @event.event_programs.each do |ev_program|
         new_ev_program = original_event.event_programs.create!(program: ev_program.program, genre: ev_program.genre)
         ev_program.event_performers.each do |ev_performer|
            new_ev_program.event_performers.create!(performer: ev_performer.performer)
         end
      end

      @event.tickets.each do |ticket|
         original_event.tickets.create!(grade: ticket.grade, price: ticket.price)
      end
   end
end
