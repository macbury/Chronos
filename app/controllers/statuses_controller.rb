class StatusesController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  respond_to :json

  def create
    @status = Status.new(params[:status])
    @stream = self.current_user.streams.create(:streamable => @status) if @status.save

    respond_with(@status, :include => [:stream])
  end

end

