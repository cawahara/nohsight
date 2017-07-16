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
         search_query = {
            start_date: params[:search][:start_date],
            address: params[:search][:address],
            keywd:   params[:search][:keywd]
         }
         events = public_events(Event.all)

         # 日付フィルター
         date_filter = events.where('start_date >= ?', search_query[:start_date])

         # 開催地フィルター
         ev_places = Place.where("address LIKE ? OR title LIKE ?", "%#{search_query[:address]}%", "%#{search_query[:address]}%")
         address_query = ''
         ev_places.each do |ev_place|
            address_query += "place_id = #{ev_place.id} OR "
         end
         if ev_places.count > 0
            address_query_count = address_query.length - 4
            address_query = address_query[0..address_query_count]
         end
         address_filter = date_filter.where(address_query)

         # 関連キーワードフィルター
         if Performer.where("full_name LIKE ?", "%#{search_query[:keywd]}%").count > 0
            # 1.出演者
            performers = Performer.where("full_name LIKE ?", "%#{search_query[:keywd]}%")
            performer_query = ''
            performers.each do |performer|
               performer_query += "performer_id = #{performer.id} OR "
            end
            if performers.count > 0
               performer_query_count = performer_query.length - 4
               performer_query = performer_query[0..performer_query_count]
            end

            ev_performers = EventPerformer.where(performer_query)
            ev_performer_query = ''
            ev_performers.each do |ev_performer|
               ev_performer_query += "id = #{ev_performer.event_program_id} OR "
            end
            if ev_performers.count > 0
               ev_performer_query_count = ev_performer_query.length - 4
               ev_performer_query = ev_performer_query[0..ev_performer_query_count]
            end
            ev_programs = EventProgram.where(ev_performer_query)

            ev_program_query = ''
            ev_programs.each do |ev_program|
               ev_program_query += "id = #{ev_program.event_id} OR "
            end
            if ev_programs.count > 0
               ev_program_query_count = ev_program_query.length - 4
               ev_program_query = ev_program_query[0..ev_program_query_count]
            end

            query_events = address_filter.where(ev_program_query)
         elsif Program.where("title LIKE ?", "%#{search_query[:keywd]}%").count > 0
            # 2.演目
            programs = Program.where("title LIKE ?", "%#{search_query[:keywd]}%")
            program_query = ''
            programs.each do |program|
               program_query += "program_id = #{program.id} OR "
            end
            if programs.count > 0
               program_query_count = program_query.length - 4
               program_query = program_query[0..program_query_count]
            end

            ev_programs = EventProgram.where(program_query)
            ev_program_query = ''
            ev_programs.each do |ev_program|
               ev_program_query += "id = #{ev_program.event_id} OR "
            end
            if ev_programs.count > 0
               ev_program_query_count = ev_program_query.length - 4
               ev_program_query = ev_program_query[0..ev_program_query_count]
            end
            query_events = address_filter.where(ev_program_query)
         else
            # 3. 公演名
            query_events = address_filter.where("title LIKE ?", "%#{search_query[:keywd]}%")
         end
         return query_events
      end
end
