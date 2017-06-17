class EventProgramsController < ApplicationController
   before_action :is_logged_in?

  def edit
     @event = Event.find(params[:id])
     @event_programs = @event.event_programs
     @performers = Performer.all
     @programs = Program.all

     @event_performers = []
     @event_programs.each do |ev_program|
        ev_program.event_performers.each do |ev_performer|
          @event_performers << ev_performer
        end
     end

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
     @event_programs = @event.event_programs
     event_program_input = event_program_params
     event_program_input.each do |event_params|
        event_params = event_program_valid?(event_params)
        if event_params == false
           flash['danger'] = "入力情報に不備があります"
           # FIXME renderアクションに変え、どの箇所に不備があるかを表示できるようにする
           redirect_to(edit_event_program_url(@event)) and return
        end
     end


     event_program_input.each do |event_params|
        case event_params['type']
        when 'update'
           event_program = EventProgram.find(event_params['id'])
           event_program.update_attributes(
                                          program_id: event_params['title'],
                                          style:      event_params['style'],
                                          genre:      event_params['genre']
                                          )
        when 'destroy'
           event_program = EventProgram.find(event_params['id'])
           event_program.destroy
        when 'create'
           event_program = @event.event_programs.build(
                                                       program_id: event_params['title'],
                                                       style:      event_params['style'],
                                                       genre:      event_params['genre']
                                                      )
           event_program.save
        end
     end
     flash[:success] = "演目を変更しました"
     redirect_to(edit_event_port_url(@event))

  end

  private
      # paramsをarrayに変換
      def event_program_params
         # FIXME permit!をパラメータを指定したpermitメソッドに置き換えるべき
         ev_programs_hash = params.require(:event_program).permit!
         ev_programs_array = []
         ev_programs_hash.each do |key, value|
            ev_programs_array << value
         end

         return ev_programs_array
      end

      def event_program_valid?(event_params)
         if event_params['type'] == 'destroy'
            return event_params
         end

         if Program.find_by(title: event_params['title']).nil?
            new_event_program = Program.new(title: event_params['title'])
            new_event_program.save
         elsif event_params['genre'].empty? || event_params['style'].empty?
            return false
         end

         event_params['title'] = Program.find_by(title: event_params['title']).id
         return event_params
      end
end
