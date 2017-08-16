# frozen_string_literal: true

class EventPerformersController < ApplicationController
   include UpdateEventAssociations
   before_action :logged_in?

   def edit
      @event = Event.find(params[:id])
      @ev_programs = @event.event_programs
      @ev_performers = []
      @ev_programs.each do |ev_program|
         @ev_performers << ev_program.event_performers
      end
      @performers = Performer.all
      @programs = Program.all
   end

   def update
      # Update relative event perfs in all methods
      @event = Event.find(params[:id])
      ev_pro_infos = get_params('event_program')
      ev_per_infos = insert_params(ev_pro_infos)
      if ev_per_infos == false
         flash['danger'] = '入力情報に不備があります'
         # FIXME: renderアクションに変え、どの箇所に不備があるかを表示できるようにする
         redirect_to(edit_event_performer_url(@event)) && return
      end

      update_performers(ev_per_infos)

      flash[:success] = '演目を変更しました'
      redirect_to(edit_event_port_url(@event))
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
end
