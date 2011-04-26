require "rubygems"
require 'mechanize'
require 'logger'
class Muzzo
  
  def initialize(login, password)
    @agent = Mechanize.new { |a| a.log = Logger.new(File.join([Rails.root, "/log/", "mech.log"])) }
    
    @agent.user_agent_alias = 'Mac Safari'
    @login = login
    @password = password
    
    page = @agent.get("http://muzzo.pl/zaloguj")
    
    login_form = page.form_with(:name => "login")
    login_form.field_with(:name => "login").value = login
    login_form.field_with(:name => "password").value = password
    
    @agent.submit(login_form)
    profile_page = @agent.get("http://muzzo.pl/profil/wizytowka")
    
    @logged_in = !profile_page.link_with(:href => "http://muzzo.pl/profil/edycja").nil?
  end
  
  def logged_in?
    @logged_in
  end
  
  def get_band_name
    page = @agent.get("http://muzzo.pl/profil/wizytowka")
    h4 = page.search(".artist_profile_top h4")
    if h4.empty?
      return nil
    else
      band_name = h4.inner_text.strip
      return band_name.empty? ? nil : band_name
    end
  end
  
  def agent
    @agent
  end
  
  # title, date, city, description
  def add_event(options={})
    page = @agent.get("http://muzzo.pl/profil/kalendarium")
    
    form = page.form_with(:action => "")
    form.field_with(:name => "event").value = options['title']
    form.field_with(:name => "date").value = options['date'].strftime("%Y-%m-%d")
    form.field_with(:name => "time").value = options['date'].strftime("%H:%M")
    form.field_with(:name => "pleace").value = options['city']
    form.field_with(:name => "description").value = options['description']
    
    @agent.submit(form)
  end
end
