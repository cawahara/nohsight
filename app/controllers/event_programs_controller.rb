# frozen_string_literal: true

class EventProgramsController < ApplicationController
   include UpdateEventAssociations
   before_action :is_logged_in?

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
      event_programs = multiple_params('event_program')
      event_programs = params_valid?(event_programs, 'program_id', 'title', Program)
      if event_programs == false
         flash['danger'] = '入力情報に不備があります'
         # FIXME: renderアクションに変え、どの箇所に不備があるかを表示できるようにする
         redirect_to(edit_event_program_url(@event)) && return
      end
      update_with_params(event_programs, ['program_id', 'genre', 'style'], EventProgram, @event.event_programs)
      flash[:success] = '演目を変更しました'
      redirect_to(edit_event_port_url(@event))
   end
end
