class SocialAccountsController < ApplicationController
  before_filter :authenticate_user!
  set_tab :accounts
  # GET /social_accounts
  # GET /social_accounts.xml
  def index
    @social_accounts = self.current_user.social_accounts.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @social_accounts }
    end
  end

  # GET /social_accounts/1
  # GET /social_accounts/1.xml
  def show
    @social_account = SocialAccount.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @social_account }
    end
  end

  # GET /social_accounts/new
  # GET /social_accounts/new.xml
  def new
    @social_account = SocialAccount.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @social_account }
    end
  end

  # GET /social_accounts/1/edit
  def edit
    @social_account = SocialAccount.find(params[:id])
  end

  # POST /social_accounts
  # POST /social_accounts.xml
  def create
    @social_account = SocialAccount.new(params[:social_account])

    respond_to do |format|
      if @social_account.save
        format.html { redirect_to(@social_account, :notice => 'Social account was successfully created.') }
        format.xml  { render :xml => @social_account, :status => :created, :location => @social_account }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @social_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /social_accounts/1
  # PUT /social_accounts/1.xml
  def update
    @social_account = SocialAccount.find(params[:id])

    respond_to do |format|
      if @social_account.update_attributes(params[:social_account])
        format.html { redirect_to(@social_account, :notice => 'Social account was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @social_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /social_accounts/1
  # DELETE /social_accounts/1.xml
  def destroy
    @social_account = SocialAccount.find(params[:id])
    @social_account.destroy

    respond_to do |format|
      format.html { redirect_to(social_accounts_url) }
      format.xml  { head :ok }
    end
  end
end
