# frozen_string_literal: true

class EventPerformersController < ApplicationController
   include UpdateEventAssociations
   before_action :logged_in?
   before_action :set_variables

   def edit
   end

   def update
      ev_programs = get_params('event_program')
      ev_performers = insert_params(ev_programs)
      if ev_performers != false
         update_performers(ev_performers)
         flash[:success] = '演目を変更しました'
         redirect_to(edit_event_port_url(@event))
      else
         flash['danger'] = '赤枠の項目内の入力情報に不備があります'
         render 'event_performers/edit'
      end
   end

   private

   def insert_params(ev_pros)
      ev_pers = []
      ev_pros.each_with_index do |ev_pro, key|
         next if ev_pro['mode'] != 'update'
         ev_per = get_params("event_performer-#{key}")
         ev_per = params_valid?(ev_per, 'performer_id', ['full_name'], Performer)
         return false if ev_per == false
         ev_pers << ev_per
      end
      return ev_pers
   end

   def update_performers(ev_per_infos)
      ev_per_infos.each do |ev_per_info|
         update_records(ev_per_info, EventPerformer.required_columns, EventPerformer)
      end
   end

   def set_variables
      @event = Event.find(params[:id])
      @ev_programs = @event.event_programs
      @ev_performers = []
      @ev_programs.each do |ev_program|
         @ev_performers << ev_program.event_performers
      end
      @performers = Performer.all
      @programs = Program.all

      @render_params = params if params[:event_program]
   end
end
