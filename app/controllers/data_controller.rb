class DataController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard
  respond_to :json
  
  def create
    file = params['file']
    file_name = ActiveSupport::SecureRandom.hex(32)+File.extname(file.original_filename)

    path = File.join(Rails.root, "tmp/uploads/", file_name)

    File.open(path, "w") { |f| f.write(file.read) }
    
    render :json => { :file_name => file_name, :file => data_url(:id => file_name) }
  end
  
  def show
    path = File.join(Rails.root, "tmp/uploads/", params[:id])
    send_file path
  end
end
