# frozen_string_literal: true

class EventPerformersController < ApplicationController
   include UpdateEventAssociations
   before_action :is_logged_in?

   def edit
      @event = Event.find(params[:id])
      @ev_progs = @event.event_programs
      @ev_perfs = []
      @ev_progs.each do |ev_prog|
         @ev_perfs << ev_prog.event_performers
      end

      @performers = Performer.all
      @programs = Program.all
   end

   def update
      # Update relative event perfs in all methods
      @event = Event.find(params[:id])
      ev_progs_input = multiple_params('event_program')
      ev_perfs_inputs = []
      ev_progs_input.each_with_index do |ev_prog, key|
         next if ev_prog['type'] != 'update'
         ev_perfs_input = multiple_params("event_performer-#{key}")
         ev_perfs_input = params_valid?(ev_perfs_input, 'performer_id', 'full_name', Performer)
         if ev_perfs_input == false
            flash['danger'] = '入力情報に不備があります'
           # FIXME: renderアクションに変え、どの箇所に不備があるかを表示できるようにする
           redirect_to(edit_event_performer_url(@event)) && return
         end
         ev_perfs_inputs << ev_perfs_input
      end

      ev_perfs_inputs.each do |ev_perfs_input|
         event_program = EventProgram.find(ev_perfs_input[0]['event_program_id'])
         update_with_params(ev_perfs_input, ['event_program_id', 'performer_id'], EventPerformer, event_program.event_performers)
      end

      flash[:success] = '演目を変更しました'
      redirect_to(edit_event_port_url(@event))
   end
end
