# frozen_string_literal: true

class StaticPagesController < ApplicationController
   before_action :change_finished_join_status, only: [:dashboard]

   def dashboard
      @events = upcoming_events(Event.all).limit(5)
   end

   def search
   end

   def about
   end

   def help
   end

   def convention
   end
end
