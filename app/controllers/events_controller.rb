# frozen_string_literal: true

class EventsController < ApplicationController
   include UpdateEventAssociations
   include SearchEngine

   before_action :set_event, except: [:index, :new, :create, :manage]
   before_action :set_variables_for_event_place, only: [:edit_place, :update_place]
   before_action :logged_in?, except: [:index, :show]
   before_action :event_editor?, except: [:index, :new, :show, :create, :manage]

   def index
      events = []
      if params[:search] || params[:easy_search]
         events = search_results
      elsif params[:user]
         user = User.find(params[:user])
         events = public_events(user.events)
      else
         events = upcoming_events(Event.all)
      end

      @event_count = events.count
      if @event_count.positive?
         flash.now[:info] = "#{@event_count}件の公演が見つかりました。"
      else
         flash.now[:warning] = '公演は見つかりませんでした。'
      end

      @events = events.page(params[:page]).per(5)
   end

   def new
      @event = Event.new
   end

   def show
   end

   def edit
   end

   def create
      @event = Event.new(event_params)
      @event.published = false
      if @event.save
         UserEvent.create!(user_id: current_user.id, event_id: @event.id, organizer: true)
         flash[:success] = '新しい公演を登録しました。編集して公開しましょう。'
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
      if admin_user?
         @events = Event.where(publishing_status: 1)
      else
         @events = @user.events
      end

   end

   def send_request
   end

   def edit_port
   end

   def edit_place
   end

   def update_place
      Place.find_or_create_by(title: event_place_params['title']) do |place|
         place.attributes = event_place_params
      end
      place = Place.find_by(title: event_place_params['title'])
      if place && @event.update_attribute(:place_id, place.id)
         flash[:success] = '会場を変更しました'
         redirect_to(edit_event_port_url(@event))
      else
         flash['danger'] = '会場が入力されていません'
         render 'events/edit_place'
      end
   end

   private

   def set_event
      @event = Event.find(params[:id])
   end

   def set_variables_for_event_place
      @place = @event.place
      @places = Place.all

      @render_params = params if params[:event_place]
   end

   def event_params
      params.require(:event).permit!
   end

   def event_place_params
      params.require(:event_place).permit(:title,
                                          :address,
                                          :official_url)
   end
end
