class EventPerformersController < ApplicationController

   def edit
      @event = Event.find(params[:id])
      @event_programs = @event.event_programs
      @performers = Performer.all
      @programs = Program.all

      @event_performers = []
      @event_programs.each do |ev_program|
         @event_performers << ev_program.event_performers
      end
      @event_performers.flatten!

      respond_to do |format|
         format.html
         format.json { render json: {
                                     event:            @event,
                                     event_programs:   @event_programs,
                                     event_performers: @event_performers,
                                     performers:       @performers,
                                     programs:         @programs
                                     } }
      end
   end

   def update
      @event = Event.find(params[:id])

      ev_programs_input = event_performers_params[0]
      ev_performers_input = event_performers_params[1]


      ev_programs_input.each_index do |ev_program_idx|
         if ev_programs_input[ev_program_idx]['type'] == 'update'
            input_key = ev_program_idx
            ev_performers_input[input_key].each do |ev_performer_param|

                  if event_performer_valid?(ev_performer_param) == false
                    flash['danger'] = "入力情報に不備があります"
                    # FIXME renderアクションに変え、どの箇所に不備があるかを表示できるようにする
                    redirect_to(edit_event_performer_url(@event)) and return
                  end

                  case ev_performer_param['type']
                  when 'update'
                     event_performer = EventPerformer.find(ev_performer_param['id'])
                     event_performer.update_attributes(performer_id: ev_performer_param['name'])
                  when 'destroy'
                     event_performer = EventPerformer.find(ev_performer_param['id'])
                     event_performer.destroy
                  when 'create'
                     @event_program = EventProgram.find(ev_performer_param['ev_program_id'])
                     event_performer = @event_program.event_performers.build(performer_id: ev_performer_param['name'])
                     event_performer.save
                  end
            end
         end
      end



      flash[:success] = "演目を変更しました"
      redirect_to(edit_port_event_url(@event))
   end

   private
      def event_performers_params
         # FIXME: permit!をなくし、受け取れるパラメータを限定する
         # Fetching Event Programs Hash
         ev_programs_req = params.require(:event_program).permit!
         ev_programs_array = []
         ev_programs_req.each do |key, value|
            ev_programs_array << value
         end

         # Fetching Event Performers Hash
         ev_performers_req = params.require(:event_performer).permit!
         ev_performers_array = []
         ev_performers_req.each do |parent_key, parent_value|
            ev_performers_child_array = []
            parent_value.each do |child_key, child_value|
               ev_performers_child_array << child_value
            end
            ev_performers_array << ev_performers_child_array
         end

         return [ev_programs_array, ev_performers_array]
      end

      def event_performer_valid?(performer_params)
         if performer_params['type'] == 'destroy'
            return true
         end

         if Performer.find_by(full_name: performer_params['name']).nil?
            return false
         end
         performer_params['name'] = Performer.find_by(full_name: performer_params['name']).id
         return performer_params
      end
end
