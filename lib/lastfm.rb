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
  
  # band, title, date, city, description
  def add_event(options={})
    page = @agent.get("http://www.lastfm.pl/events/add?artistNames[]=#{CGI.escape(options['band'])}")
    
    event_form = page.form_with(:action => /\/events\/add/i)
    event_form.field_with(:name => "festivalName").value = options['title']
    
    date = options['date']
    event_form.field_with(:name => "startday").value = date.day
    event_form.field_with(:name => "startmonth").value = date.month
    event_form.field_with(:name => "startyear").value = date.year
    
    event_form.field_with(:name => "starttime").value = date.strftime("%H:%M")
    
    page = @agent.submit(event_form)
    event_form = page.form_with(:action => /\/events\/add/i)
    event_form.field_with(:name => "venue").value = options['venue']
    event_form.field_with(:name => "city").value = options['city']
    
    page = @agent.submit(event_form)
    event_form = page.form_with(:action => /\/events\/add/i)
    event_form.radiobuttons_with(:name => "venueid", :value => "8780080").check
    
    page = @agent.submit(event_form)
    
    event_form = page.form_with(:action => /\/events\/add/i)
    event_form.field_with(:name => "description").value = options['description']
    page = @agent.submit(event_form)
    
    #/​event/​1920060+Test/​edit
    edit_more = page.search("a.togglerCollapsed")
    puts edit_more["href"]
    if edit_more["href"] =~ /([0-9]+)/i
      event_id = $1
    else
      return false
    end
    
    return event_id
  end
  
  def publish_on_wall(band_name, content)
    url = "http://www.lastfm.pl/music/#{CGI.escape(band_name)}"
    page = @agent.get(url)
    comment_form = page.form_with(:action => /\/music\/#{band_name}\/\+shoutbox\/add/i)
    comment_form.field_with(:name => "message").value = content
    
    @agent.submit(comment_form)
  end
  
  def get_band_name
    page = @agent.get("http://musicmanager.last.fm/")
    h1 = page.search("#welcome h1")
    if h1.empty?
      return nil
    else
      band_name = h1.inner_text.split(",").last.strip
      return band_name.empty? ? nil : band_name
    end
  end
  
  def agent
    @agent
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
