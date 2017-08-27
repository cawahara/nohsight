# frozen_string_literal: true

class EventProgramsController < ApplicationController
   include UpdateEventAssociations
   before_action :logged_in?
   before_action :set_variables

   def edit
   end

   def update
      ev_programs = get_params('event_program')
      ev_programs = params_valid?(ev_programs, 'program_id', ['title'], Program)
      if ev_programs != false
         update_records(ev_programs, EventProgram.required_columns, EventProgram)
         flash[:success] = '演目を変更しました'
         redirect_to(edit_event_port_url(@event))
      else
         flash['danger'] = "赤枠の項目が未入力です"
         render 'event_programs/edit'
      end
   end

   private

   def set_variables
      @event = Event.find(params[:id])
      @event = Event.find(params[:id])
      @event_programs = @event.event_programs
      @event_performers = []
      @event_programs.each do |event_program|
         @event_performers << event_program.event_performers
      end
      @performers = Performer.all
      @programs = Program.all

      @ev_program_params = params[:event_program] if params[:event_program]
   end
end
