class EventsController < ApplicationController

   def new
      @event = Event.new()
   end

   def show
      @event = Event.find(params[:id])
   end

   def edit
   end

   def create
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
                                       :official_url
                                       )
      end
end
