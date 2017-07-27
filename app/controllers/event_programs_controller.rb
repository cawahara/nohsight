# frozen_string_literal: true

class EventProgramsController < ApplicationController
   include UpdateEventAssociations
   before_action :logged_in?

   def edit
      @event = Event.find(params[:id])
      @event_programs = @event.event_programs
      @event_performers = []
      @event_programs.each do |event_program|
         @event_performers << event_program.event_performers
      end
      @performers = Performer.all
      @programs = Program.all
   end

   def update
      @event = Event.find(params[:id])
      ev_programs = get_params('event_program')
      ev_programs = params_valid?(ev_programs, 'program_id', 'title', Program)
      if ev_programs == false
         flash['danger'] = '入力情報に不備があります'
         # FIXME: renderアクションに変え、どの箇所に不備があるかを表示できるようにする
         redirect_to(edit_event_program_url(@event)) && return
      end
      update_records(ev_programs, EventProgram.required_columns, EventProgram)
      flash[:success] = '演目を変更しました'
      redirect_to(edit_event_port_url(@event))
   end
end
