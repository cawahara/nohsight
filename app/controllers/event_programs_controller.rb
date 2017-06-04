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
     @event_programs.each do |ev_program|
        case value['type']

        when 'update'

        when 'destroy'

        when 'create'

        end
     end


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



end
