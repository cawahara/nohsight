class EventsController < ApplicationController

   def new
      @event = Event.new()
   end

   def show
      @event = Event.find(params[:id])
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
         flash[:success] = "新しいイベントを記録しました。編集して開催しましょう。"
         redirect_to(edit_event_url(@event))
      else
         flash[:danger] = "公演名が入力されていません"
         render 'events/new'
      end
   end

   def update
   end

   def destroy
   end

   def edit_place
      @event = Event.find(params[:id])
      @place = @event.place
      @places = Place.all
      respond_to do |format|
         format.html
         format.json { render json: {
                                     event:     @event,
                                     place:     @place,
                                     places:    @places
                                     } }
      end
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
      redirect_to(edit_port_event_url(@event))
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
end
