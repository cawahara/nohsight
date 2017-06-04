class EventProgramsController < ApplicationController
  def edit
     @event = Event.find(params[:id])
     @event_programs = @event.event_programs
  end

  def create
  end

  def update
     @event = Event.find(params[:id])
     @event_programs = event_program_params

     # TODO: vueコンポーネント構築後、各EventProgramインスタンスのトランザクション処理を記入する
     if !event_program_valid?(@event_programs)
        flash['danger'] = "入力情報に不備があります"
        render 'edit'
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

        end
     end
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

      def event_program_valid?(ev_programs)
         ev_programs.each do |ev_program|
            if Program.find_by(title: ev_program['title']).nil?
               return false
            elsif Performer.find_by(full_name: ev_program['performer']).nil?
               return false
            elsif ev_program['genre'].empty? || ev_program['style'].empty?
               return false
            end
            ev_program['title'] = Program.find_by(title: ev_program['title']).id
            # TODO: Event Performerの追加
            return true
         end
      end

end
