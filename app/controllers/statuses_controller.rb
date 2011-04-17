class StatusesController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  respond_to :json

  def create
    @status = Status.new(:body => params[:body])
    @stream = self.current_user.streams.create(:streamable => @status) if @status.save

    respond_with(@status)
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_with(@status)
  end

end

