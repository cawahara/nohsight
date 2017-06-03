class EventProgramsController < ApplicationController
  def edit
     @event_programs = Event.find(params[:id]).event_programs
  end

  def create
  end

  def update
  end

  def destroy
  end
end
