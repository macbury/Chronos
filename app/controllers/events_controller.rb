class EventsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  respond_to :json

  def create
    @event = Event.new(params[:event])
    @stream = self.current_user.streams.create(:streamable => @event) if @event.save

    respond_with(@event, :include => [:stream])
  end
  
  def upload
    file = params['file']
    file_name = ActiveSupport::SecureRandom.hex(32)+File.extname(file.original_filename)

    path = File.join(Rails.root, "tmp/uploads/", file_name)

    File.open(path, "w") { |f| f.write(file.read) }
    
    render :json => { :file_name => file_name, :file => preview_events_url(:id => file_name) }
  end
  
  def preview
    path = File.join(Rails.root, "tmp/uploads/", params[:id])
    send_file path
  end
  
end

