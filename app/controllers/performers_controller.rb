# frozen_string_literal: true

class PerformersController < ApplicationController
=begin
   before_action :logged_in?

   REVIEW: indexをvueがデータを引き出すためのストレージにすべきか(多分json枠もしくは別actionから引き出す)
   def index
      @performers = Performer.all
   end

   def show
      @performer = Performer.find(params[:id])
   end

   def new
      @performer = Performer.new
   end

   def edit
      @performer = Performer.find(params[:id])
   end

   def create
      @performer = Performer.new(performer_params)
      if @performer.save
         flash['success'] = '演者を登録しました'
         redirect_to(performer_url(@performer))
      else
         flash['danger'] = '入力情報に不備があります'
         render 'performers/new'
      end
   end

   def update
      @performer = Performer.find(params[:id])
      if @performer.update_attributes(performer_params)
         flash['success'] = '演者情報を更新しました'
         redirect_to(performer_url(@performer))
      else
         flash['danger'] = '入力情報に不備があります'
         render 'performers/edit'
      end
   end

   def destroy
      @performer = Performer.find(params[:id])
      if @performer.destroy
         flash['info'] = '演者を削除しました'
      else
         flash['danger'] = '演者を削除できません'
      end
      redirect_to(performers_url)
   end

   private

   def performer_params
      params.require(:performer).permit(:full_name,
                                        :last_name,
                                        :first_name,
                                        :style_id)
   end
=end
end
