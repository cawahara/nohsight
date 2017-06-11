class EventPerformersController < ApplicationController

   def edit
      @event = Event.find(params[:id])
      @event_programs = @event.event_programs
      @performers = Performer.all
   end

   def update
   end
end
