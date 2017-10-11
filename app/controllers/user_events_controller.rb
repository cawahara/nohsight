# frozen_string_literal: true

class UserEventsController < ApplicationController
   include SetVariablesOnEventsController

   before_action :logged_in?

   def create
      @event = Event.find(params[:id])
      flash[:success] = '公演に新しく情報を追加して更新しましょう'
      values_on_edit('create')
      render 'events/new'
   end

   def destroy
      # TODO: 実装未定
   end
end
