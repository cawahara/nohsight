# frozen_string_literal: true

class EventsController < ApplicationController
   include UpdateEventAssociations
   include SearchEngine

   include CRUDEvent
   include SetVariablesOnEventsController

   before_action :set_event, except: [:index, :new, :create, :manage, :validation]
   before_action :set_variables_for_event_place, only: [:edit_place, :update_place]
   before_action :logged_in?, except: [:index, :show]
   before_action :event_editor?, except: [:index, :new, :show, :create, :manage, :validation]

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
      values_on_edit('create')
   end

   def show
      if @event.publishing_status < 3
         flash[:danger] = '公開されていない情報にはアクセスできません。'
         redirect_to root_url
      end
   end

   def edit
      values_on_edit('update')
      if @event.publishing_status != 0 && @event.publishing_status != 2
         if @event.publishing_status == 1
            flash.now[:danger] = '承認待ちの情報の編集は禁止されています。'
         else
            flash.now[:danger] = '公開中の情報の編集は禁止されています。'
         end
         redirect_to event_manage_url
      end
   end

   def create
      request_params
      tmp_result = create_event
      if tmp_result != false
         @event = tmp_result
         send_request
      else
         if params[:id].present?
            @event = Event.find(params[:id].to_i)
            @event_params[:id] ||= @event&.id
            @event_params[:flyers] ||= @event&.flyers
         end
         flash.now[:danger] = '入力情報に不備があります。'
         render 'events/new'
      end
   end

   def update
      request_params
      if update_event(@event) != false
         send_request
      else
         flash.now[:danger] = '入力情報に不備があります。'
         render 'events/edit'
      end
   end

   def destroy
      if @event.destroy
         flash[:warning] = '公演を削除しました'
      else
         flash[:danger] = '公演の削除に失敗しました'
      end
      redirect_to event_manage_url
   end

   def manage
      @events = current_user.events
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

   def request_params
      @event_params = params&.require(:event).permit!
      @flyers_params = params.include?(:flyer) ? params&.require(:flyer).permit({ images: [] }) : { images: [] }
      @place_params = params&.require(:place).permit!
      @event_programs_params = set_empty_event_program_params
      @tickets_params = set_empty_ticket_params
      @error_msgs ||= {}
   end

   def event_place_params
      params.require(:event_place).permit(:title,
                                          :address,
                                          :official_url)
   end

   def send_request
      @event.update_attributes!(publishing_status: 1)
      flash[:success] = '公演情報を保存し、登録申請しました。'
      redirect_to event_manage_url
   end
end
