class UpdatesController < ApplicationController
  before_filter :authenticate_user!
  
  def chart
    out = []
    
    visits = []
    last = 0
    7.downto(1).each do |day|
      visits << [ day.days.ago.at_beginning_of_day.to_i * 1000, last ]
      last += 1 + (rand * 30).round
    end
    
    out << { :label => "Wizyty", :data => visits }
    
    comments = []
    last = 0
    7.downto(1).each do |day|
      comments << [ day.days.ago.at_beginning_of_day.to_i * 1000, last ]
      last += 1 + (rand * 5).round
    end
    
    out << { :label => "Komentarze", :data => comments }
    
    likes = []
    last = 0
    7.downto(1).each do |day|
      likes << [ day.days.ago.at_beginning_of_day.to_i * 1000, last ]
      last += 1 + (rand * 10).round
    end
    
    out << { :label => "Lubie to", :data => likes }
    
    render :json => out
  end
  
  # GET /updates
  # GET /updates.xml
  def index
    @updates = Update.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @updates }
      format.json { render :json => @updates }
    end
  end

  # GET /updates/1
  # GET /updates/1.xml
  def show
    @update = Update.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @update }
    end
  end

  # GET /updates/new
  # GET /updates/new.xml
  def new
    @update = Update.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @update }
    end
  end

  # GET /updates/1/edit
  def edit
    @update = Update.find(params[:id])
  end

  # POST /updates
  # POST /updates.xml
  def create
    @update = self.current_user.updates.new(params[:update])

    respond_to do |format|
      if @update.save
        format.html { redirect_to(@update, :notice => 'Update was successfully created.') }
        format.xml  { render :xml => @update, :status => :created, :location => @update }
        format.json  { render :json => @update, :status => :created, :location => @update }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @update.errors, :status => :unprocessable_entity }
        format.json  { render :json => @update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /updates/1
  # PUT /updates/1.xml
  def update
    @update = Update.find(params[:id])

    respond_to do |format|
      if @update.update_attributes(params[:update])
        format.html { redirect_to(@update, :notice => 'Update was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @update.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /updates/1
  # DELETE /updates/1.xml
  def destroy
    @update = Update.find(params[:id])
    @update.destroy

    respond_to do |format|
      format.html { redirect_to(updates_url) }
      format.xml  { head :ok }
    end
  end
end
