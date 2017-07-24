# frozen_string_literal: true

class EventPerformersController < ApplicationController
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

      ev_progs_input = ev_perf_params[0]
      ev_perfs_input = ev_perf_params[1]
      ev_progs_input.each_index do |ev_prog_idx|
         next if ev_progs_input[ev_prog_idx]['type'] != 'update'
         input_key = ev_prog_idx
         ev_perfs_input[input_key].each do |ev_perf_param|
            ev_perf_param = ev_perf_valid?(ev_perf_param)
            if ev_perf_param == false
               flash['danger'] = '入力情報に不備があります'
              # FIXME: renderアクションに変え、どの箇所に不備があるかを表示できるようにする
              redirect_to(edit_event_performer_url(@event)) && return
            end
            case ev_perf_param['type']
            when 'update'
               ev_perf = EventPerformer.find(ev_perf_param['id'])
               ev_perf.update_attributes(performer_id: ev_perf_param['name'])
            when 'destroy'
               ev_perf = EventPerformer.find(ev_perf_param['id'])
               ev_perf.destroy
            when 'create'
               @ev_prog = EventProgram.find(ev_perf_param['ev_program_id'])
               ev_perf = @ev_prog.event_performers.build(performer_id: ev_perf_param['name'])
               ev_perf.save
            end
         end
      end

      flash[:success] = '演目を変更しました'
      redirect_to(edit_event_port_url(@event))
   end

   private

   def ev_perf_params
      # FIXME: permit!をなくし、受け取れるパラメータを限定する
      # Fetching Event Programs Hash
      ev_progs_req = params.require(:event_program).permit!
      ev_progs_array = []
      ev_progs_req.each do |key, value|
         ev_progs_array << value
      end

      # Fetching Event perfs Hash
      ev_perfs_req = params.require(:event_performer).permit!
      ev_perfs_array = []
      ev_perfs_req.each do |parent_key, parent_value|
         ev_perfs_child_array = []
         parent_value.each do |child_key, child_value|
            ev_perfs_child_array << child_value
         end
         ev_perfs_array << ev_perfs_child_array
      end

      return [ev_progs_array, ev_perfs_array]
   end

   def ev_perf_valid?(perf_params)
      return perf_params if perf_params['type'] == 'destroy'
      
      if perf_params['name'].empty?
         return false
      end

      if Performer.find_by(full_name: perf_params['name']).nil?
         new_ev_perf = Performer.new(full_name: perf_params['name'], first_name: nil, last_name: nil, style_id: 1)
         new_ev_perf.save
      end

      perf_params['name'] = Performer.find_by(full_name: perf_params['name']).id
      return perf_params
   end
end
