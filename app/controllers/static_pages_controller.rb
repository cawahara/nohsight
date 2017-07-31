# frozen_string_literal: true

class StaticPagesController < ApplicationController

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
