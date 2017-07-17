class EventsController < ApplicationController
   before_action :is_logged_in?, only: [:new, :edit_manage, :edit_port, :edit, :create, :update, :destroy, :edit_place, :update_place]

   def index
      @events = search_result.page(params[:id]).per(5)
   end

   def new
      @event = Event.new()
   end

   def show
      @event = Event.find(params[:id])
      @user_events = UserEvent.where(event_id: @event.id)

      locations = []
      if @event.event_programs.count > 0
         @event.event_programs.each do |ev_program|
            locations << ev_program.program.place
         end
      end

      respond_to do |format|
         format.html
         format.json { render json: {
                                    event:      @event,
                                    locations:  locations
                                    } }
      end
   end

   def edit_manage
      @user = current_user
      @events = Event.where(user_id: @user.id)
      @user_events = UserEvent.where(user_id: @user.id)
   end

   def edit_port
      @event = Event.find(params[:id])
   end

   def edit
      @event = Event.find(params[:id])
   end

   def create
      @event = current_user.events.build(event_params)
      @event.published = false
      if @event.save
         flash[:success] = "新しい公演を作成しました。編集して開催しましょう。"
         redirect_to(edit_event_port_url(@event))
      else
         flash[:danger] = "公演名が入力されていません"
         render 'events/new'
      end
   end

   def update
      @event = Event.find(params[:id])
      if @event.update_attributes(event_params)
         flash[:success] = "公演情報を更新しました"
         redirect_to(edit_event_port_url(@event))
      else
         flash[:danger] = "入力情報に不備があります"
         render 'events/edit'
      end
   end

   def destroy
      @event = Event.find(params[:id])
      if @event.destroy
         flash[:warning] = "公演を削除しました"
         redirect_to(edit_event_manage_url)
      else
         flash[:danger] = "公演の削除に失敗しました"
         redirect_to(edit_event_manage_url)
      end
   end

   def edit_place
      @event = Event.find(params[:id])
      @place = @event.place
      @places = Place.all
   end

   def update_place
      @event = Event.find(params[:id])
      place_param = event_place_params
      @event_place = Place.find_by(title: place_param['title'])
      if @event_place
         @event.update_attributes(place_id: @event_place.id)
      else
         if place_param['title'].empty?
            flash['danger'] = '会場が入力されていません'
            redirect_to(edit_event_place_url(@event)) and return
         end

         new_event_place = Place.new(
                                    title: place_param['title'],
                                    address: place_param['address'],
                                    official_url: place_param['official_url']
                                    )
         new_event_place.save
         @event_place = Place.find_by(title: place_param['title'])
         @event.update_attributes(place_id: @event_place.id)
      end
      flash[:success] = "会場を変更しました"
      redirect_to(edit_event_port_url(@event))
   end

   private
      def event_params
         params.require(:event).permit(
                                       :title,
                                       :start_date,
                                       :end_date,
                                       :information,
                                       :official_url,
                                       :published
                                       )
      end

      def event_place_params
         params.require(:event_place).permit(
                                       :title,
                                       :address,
                                       :official_url
                                       )
      end

      # 疑似検索エンジン
      def search_result
         search_params = {
            start_date: params[:search][:start_date],
            end_date: params[:search][:end_date],
            keywd:   params[:search][:keywd],
            locations: params[:search][:locations]
         }

         search_result = public_events(Event.all.order(start_date: :desc))
         # 日付フィルター
            # 範囲(from)
            if search_params[:start_date] != ""
               start_query = "start_date >= '#{search_params[:start_date]}'"
               search_result = search_result.where(start_query)
            end
            # 範囲(to)
            if search_params[:end_date] != ""
               end_query = "start_date <= '#{search_params[:end_date]}'"
               search_result = search_result.where(end_query)
            end

         # 開催地フィルター
            if search_params[:locations] != ""
               locations = search_params[:locations].split(',')
               query_for_places = ""
               locations.each do |location|
                  query_for_places += "address LIKE '%#{location}%' OR "
               end
               query_for_places = query_for_places[0..(query_for_places.length - 5)]
               relative_places = Place.where(query_for_places)

               locations_query = ""
               relative_places.each do |place|
                  locations_query += "place_id = #{place.id} OR "
               end
               locations_query = locations_query[0..(locations_query.length - 5)]
               search_result = search_result.where(locations_query)
            end

         # キーワードフィルター
            if search_params[:keywd] != ""
               keywds = search_params[:keywd].split(/\s/)
               keywd_query = ""

               # 出演者
               query_for_performers = ""
               keywds.each do |keywd|
                  query_for_performers += "full_name LIKE '%#{keywd}%' OR "
               end
               query_for_performers = query_for_performers[0..(query_for_performers.length - 5)]
               relative_performers = Performer.where(query_for_performers)

               event_performers = []
               relative_performers.each do |performer|
                  event_performers << EventPerformer.where("performer_id = #{performer.id}")
               end
               event_performers = event_performers.flatten

               event_programs = []
               event_performers.each do |ev_performer|
                  event_programs << EventProgram.find(ev_performer.event_program_id)
               end
               event_programs = event_programs.uniq

               performers_query = ""
               event_programs.each do |ev_program|
                  performers_query += "id = #{ev_program.event_id} OR "
               end
               keywd_query += performers_query

               # 演目
               query_for_programs = ""
               keywds.each do |keywd|
                  query_for_programs += "title LIKE '%#{keywd}%' OR "
               end
               query_for_programs = query_for_programs[0..(query_for_programs.length - 5)]
               relative_programs = Program.where(query_for_programs)

               event_programs = []
               relative_programs.each do |program|
                  event_programs << EventProgram.where("program_id = #{program.id}")
               end
               event_programs = event_programs.flatten

               programs_query = ""
               event_programs.each do |ev_program|
                  programs_query += "id = #{ev_program.event_id} OR "
               end
               keywd_query +=  programs_query

               # 公演名
               events_query = ""
               keywds.each do |keywd|
                  events_query += "title LIKE '%#{keywd}%' OR "
               end
               keywd_query += events_query
               keywd_query = keywd_query[0..(keywd_query.length - 5)]
               search_result = search_result.where(keywd_query)
            end
            return search_result
      end
end
