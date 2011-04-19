class EventsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  respond_to :json

  def create
    @event = Event.new(params[:event])
    @stream = self.current_user.streams.create(:streamable => @event) if @event.save

    respond_with(@event)
  end

end

