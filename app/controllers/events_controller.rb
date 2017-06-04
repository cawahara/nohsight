class EventsController < ApplicationController

   def new
      @event = Event.new()
   end

   def show
      @event = Event.find(params[:id])
   end

   def edit_port
      @event = Event.find(params[:id])
   end

   def edit
      @event = Event.find(params[:id])
   end

   def create
      @event = current_user.events.build(event_params)
      binding.pry
      @event.published = false
      if @event.save
         flash[:success] = "新しいイベントを記録しました。編集して開催しましょう。"
         redirect_to(edit_event_url(@event))
      else
         flash[:danger] = "公演名が入力されていません"
         render 'events/new'
      end
   end

   def update
   end

   def destroy
   end

   private
      def event_params
         params.require(:event).permit(
                                       :title,
                                       :start_date,
                                       :end_date,
                                       :information,
                                       :official_url,
                                       :published
                                       )
      end
end
