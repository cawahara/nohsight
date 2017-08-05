# frozen_string_literal: true

class EventsController < ApplicationController
   include UpdateEventAssociations
   include SearchEngine
   before_action :logged_in?, except: [:index, :show]
   before_action :event_editor?, except: [:index, :new, :show, :create, :manage]
   before_action :the_event, except: [:index, :new, :create, :manage]

   def index
      events = []
      if params[:search] || params[:easy_search]
         events = search_results
      elsif params[:user]
         user = User.find(params[:user])
         events = public_events(Event.all).where(id: user.user_events.ids)
      else
         events = upcoming_events(Event.all)
      end
      flash.now[:warning] = '公演は見つかりませんでした。' if events.count == 0
      @event_count = events.count
      @events = events.page(params[:page]).per(5)
   end

   def new
      @event = Event.new
   end

   def show
      @user_events = UserEvent.where(event_id: @event.id)
      locations = relative_program_locations(@event)
      respond_to do |format|
         format.html
         format.json do
            render json: { event:     @event,
                           locations: locations }
         end
      end
   end

   def edit
   end

   def create
      @event = Event.new(event_params)
      @event.published = false
      if @event.save
         UserEvent.create!(user_id: current_user.id,
                           event_id: @event.id,
                           organizer: true)
         flash[:success] = '新しい公演を作成しました。編集して開催しましょう。'
         redirect_to(edit_event_port_url(@event))
      else
         flash[:danger] = '公演名が入力されていません'
         render 'events/new'
      end
   end

   def update
      if @event.update_attributes(event_params)
         flash[:success] = '公演情報を更新しました'
         redirect_to(edit_event_port_url(@event))
      else
         flash[:danger] = '入力情報に不備があります'
         render 'events/edit'
      end
   end

   def destroy
      if @event.destroy
         flash[:warning] = '公演を削除しました'
      else
         flash[:danger] = '公演の削除に失敗しました'
      end
      redirect_to(event_manage_url)
   end

   def manage
      @user = current_user
      @user_events = @user.user_events
   end

   def edit_port
   end

   def edit_place
      @place = @event.place
      @places = Place.all
   end

   def update_place
      place_info = event_place_params
      place_info = params_valid?([place_info], 'place_id', ['title', 'address'], Place)
      if place_info == false
         flash['danger'] = '会場が入力されていません'
         redirect_to(edit_event_place_url(@event)) && return
      end
      update_records(place_info, ['place_id'], Event)
      flash[:success] = '会場を変更しました'
      redirect_to(edit_event_port_url(@event))
   end

   private

   def the_event
      @event = Event.find(params[:id])
   end

   def event_params
      params.require(:event).permit!
   end

   def event_place_params
      params.require(:event_place).permit!
      params[:event_place]['type'] = 'update'
      params[:event_place]['id'] = params[:id]
      return params[:event_place]
   end

   def relative_program_locations(event)
      locations = []
      if event.event_programs.count.positive?
         event.event_programs.each do |ev_program|
            locations << ev_program.program.place
         end
      end
      return locations
   end
end
