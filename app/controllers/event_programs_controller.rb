class EventProgramsController < ApplicationController
  def edit
     @event = Event.find(params[:id])
     @event_programs = @event.event_programs
     @programs = Program.all
  end

  def create
  end

  def update
     @event = Event.find(params[:id])
     @event_programs = event_program_params

     @event_programs.each do |event_params|
        event_params = event_program_valid?(event_params)
        if event_params == false
           flash['danger'] = "入力情報に不備があります"
           render 'edit'
        end
     end


     @event_programs.each do |event_params|
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
     redirect_to(edit_port_event_url(@event))

  end

  def destroy
  end

  private
      # paramsをarrayに変換
      def event_program_params
         # FIXME permit!をパラメータを指定したpermitメソッドに置き換えるべき
         ev_programs_hash = params.require(:ev_program).permit!

         ev_programs_array = []
         ev_programs_hash.each do |key, value|
            ev_programs_array << value
         end
         return ev_programs_array
      end

      def event_program_valid?(event_params)
         if Program.find_by(title: event_params['title']).nil?
            return false
         elsif Performer.find_by(full_name: event_params['performer']).nil?
            return false
         elsif event_params['genre'].empty? || event_params['style'].empty?
            return false
         end
         event_params['title'] = Program.find_by(title: event_params['title']).id
         # TODO: Event Performerの追加
         return event_params
      end

end
