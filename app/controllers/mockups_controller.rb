class MockupsController < ApplicationController
  def dashboard
     @user = User.find(1)
     @events = Event.all
  end

  def search

  end

  def detail
     @event = Event.find(params[:id])
  end
end
