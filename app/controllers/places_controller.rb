class PlacesController < ApplicationController
   def edit
      @event = Event.find(params[:id])
   end

   def create
   end

   def update
   end

   def destroy
   end
end
