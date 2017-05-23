class StaticPagesController < ApplicationController

  def dashboard
     @events = public_events
  end

  def about
  end

  def help
  end

  def convention
  end

end
