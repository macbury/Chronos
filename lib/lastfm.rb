require "rubygems"
require 'mechanize'
require 'logger'

class LastFm
  Site = "www.last.fm"
  
  def initialize(login, password)
    @agent = Mechanize.new { |a| a.log = Logger.new(File.join([Rails.root, "/log/", "mech.log"])) }
    @agent.user_agent_alias = 'Mac Safari'
    @login = login
    @password = password
    page = @agent.get("https://www.last.fm/login?lang=pl&backto=http%3A%2F%2Fwww.lastfm.pl%2Flogin%2FsuccessCallback%3Furl%3Dhttp%253A%252F%252Fwww.lastfm.pl%252F%253Fsetlang%253Dpl&withsid&s=0&r=0&joinurl=http%3A%2F%2Fwww.lastfm.pl%2F%3Fsetlang%3Dpl")
    
    login_form = page.form_with(:action => "/login/?lang=pl")
    login_form.field_with(:name => "username").value = login
    login_form.field_with(:name => "password").value = password
    
    profile_page = @agent.submit(login_form)
    
    @logged_in = !profile_page.search("#idBadgerUser").empty?
  end
  
  def publish_on_wall(band_url, content)
    
  end
  
  def logged_in?
    @logged_in
  end
  
  def login
    @login
  end
  
  def password
    @password
  end
  
end
