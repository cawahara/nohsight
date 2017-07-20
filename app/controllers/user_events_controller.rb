# frozen_string_literal: true

class UserEventsController < ApplicationController
   before_action :is_logged_in?

   def create
      # REVIEW: 変数の代入について考慮(ABC Detection検査における計算量の関係上、
      # =>      params[[:id]]を下記の入力値に直接おく形に。params[:id]が何を示すか一目でわかるかが不安)
      @user_event = current_user.user_events.build(user_id: current_user.id,
                                                   event_id: params[:id])
      if @user_event.save
         flash[:success] = '新たな公演編集メンバーになりました'
         redirect_to(edit_event_port_url(@event))
      else
         flash[:danger] = '編集不可能です'
         render 'events/show'
      end
   end

   def destroy
      # TODO: 実装未定
   end
end
