class EventPerformersController < ApplicationController

   def edit
      @event = Event.find(params[:id])
      @event_programs = @event.event_programs
   end

   def update
   end
end
