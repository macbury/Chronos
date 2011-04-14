class StatusesController < ApplicationController
  before_filter :authenticate_user!
  set_tab :dashboard

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new(params[:status])
    respond_to do |format|
      if @status.save
        self.current_user.streams.create(:streamable => @status)
        format.html { redirect_to(dashboard_path, :notice => 'Status was successfully created.') }
        format.xml  { render :xml => @status, :status => :created, :location => @status }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.xml
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to(statuses_url) }
      format.xml  { head :ok }
    end
  end
  
end
