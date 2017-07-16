class PlacesController < ApplicationController
   before_action :is_logged_in?

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
