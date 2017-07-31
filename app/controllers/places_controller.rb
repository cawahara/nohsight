# frozen_string_literal: true

class PlacesController < ApplicationController
   before_action :logged_in?

   def index
      @places = Place.all
   end

   def show
      @place = Place.find(params[:id])
   end

   def new
      @place = Place.new
   end

   def edit
      @place = Place.find(params[:id])
   end

   def create
      @place = Place.new(place_params)
      if @place.save
         flash['success'] = 'エリアを登録しました'
         redirect_to(place_url(@place))
      else
         flash['danger'] = '入力情報に不備があります'
         render 'places/new'
      end
   end

   def update
      @place = Place.find(params[:id])
      if @place.update_attributes(place_params)
         flash['success'] = 'エリア情報を更新しました'
         redirect_to(place_url(@place))
      else
         flash['danger'] = '入力情報に不備があります'
         render 'places/edit'
      end
   end

   def destroy
      @place = Place.find(params[:id])
      if @place.destroy
         flash['info'] = 'エリアを削除しました'
      else
         flash['danger'] = 'エリアを削除できません'
      end
      redirect_to(places_url)
   end

   private

   def place_params
      params.require(:place).permit(:title,
                                    :address,
                                    :official_url)
   end
end
