class StaticPagesController < ApplicationController

  def dashboard
     @events = Event.all
  end

  def about
  end

  def help
  end

  def convention
  end
  
end
