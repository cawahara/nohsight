class EventProgramsController < ApplicationController
  def edit
     @event = Event.find(params[:id])
     @event_programs = @event.event_programs
     @programs = Program.all
     @places = Place.all
  end

  def update
     @event = Event.find(params[:id])
     @event_programs = @event.event_programs
     event_program_input = event_program_params

     event_program_input.each do |event_params|
        event_params = event_program_valid?(event_params)
        if event_params == false
           flash['danger'] = "入力情報に不備があります"
           render 'edit' and return
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
     redirect_to(edit_port_event_url(@event))

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
         if event_params['type'] == 'destroy'
            return true
         end

         if Place.find_by(title: event_params['place']).nil?
            return false
         elsif Program.find_by(title: event_params['title']).nil?
            return false
         elsif event_params['genre'].empty? || event_params['style'].empty?
            return false
         end

         event_params['title'] = Program.find_by(title: event_params['title']).id
         return event_params
      end
=begin
 {  "type"=>"",
    "id"=>"2",
    "genre"=>"狂言",
    "style"=>"大蔵流"
    "title"=>"芦刈",
    "category"=>"二番目",
    "duration"=>"50",
    "place"=>"摂津国分寺",
    "address"=>"Japan, 〒543-0044 Ōsaka-fu, Ōsaka-shi, Tennōji-ku, Kokubuchō, １４ 〒543-0044 国分 公園 内",
    "official_url"=>"http://www.city.osaka.lg.jp/kensetsu/page/0000009761.html",}

    REVIEW: Place => Program => EventProgramの順にレコードを操作するが、
            入力内容がPlace, Programテーブルに存在しない場合、どう処理するべき？
            1. renderしてエラーを出力　　2.新たにレコードに加える
                                          => いくつかのフィールドにあるバリデを消さないと入力がスムーズに進まない
                                          => 能楽師や開発サイドで未入力項目を定期的に探り、保管する必要あり？
=end
end