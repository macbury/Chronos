require File.join([Rails.root, '/lib', '/oa_blip.rb'])
require File.join([Rails.root, '/lib', '/oa_flaker.rb'])
require File.join([Rails.root, '/lib', '/oa_myspace.rb'])
require File.join([Rails.root, '/lib', '/lastfm.rb'])
providers = YAML.load_file(File.join([Rails.root, "config", "providers.yml"]))[Rails.env]
require "myspace"
PROVIDERS_CONFIG = providers

Rails.application.config.middleware.use OmniAuth::Builder do
  providers.each do |provider_name, config|
    next if config.nil?
    if provider_name.to_sym == :facebook
      provider provider_name.to_sym, config['app_id'], config['secret'], { :scope => "manage_pages, offline_access, publish_stream, create_event" }
    elsif provider_name.to_sym == :myspace
      Rails.logger.debug "Myspace provider..."
      provider provider_name.to_sym, config['app_id'], config['secret'], { :authorize_params => {'myspaceid.permissions' => "ViewFullProfileInfo|AddPhotosAlbums|UpdateMoodStatus|AllowActivitiesAutoPublish"} }
    else
      provider provider_name.to_sym, config['app_id'], config['secret']
    end
  end
end

module Clients
  
  def self.twitter(token, secret)
    consumer = OAuth::Consumer.new(PROVIDERS_CONFIG["twitter"]["app_id"], PROVIDERS_CONFIG["twitter"]["secret"], :site => "https://api.twitter.com" ) 
    access_token = OAuth::AccessToken.new(consumer, token, secret)
    return access_token
  end
  
  def self.blip(token, secret)
    consumer = OAuth::Consumer.new(PROVIDERS_CONFIG["blip"]["app_id"], PROVIDERS_CONFIG["blip"]["secret"], :site => "http://api.blip.pl/" ) 
    access_token = OAuth::AccessToken.new(consumer, token, secret)
    return access_token
  end
  
  def self.myspace(token, secret)
    myspace = MySpace::MySpace.new(PROVIDERS_CONFIG["myspace"]["app_id"], PROVIDERS_CONFIG["myspace"]["secret"], :access_token => token, :access_token_secret => secret)
  end
  
  def self.flaker(token, secret)
    consumer = OAuth::Consumer.new(PROVIDERS_CONFIG["flaker"]["app_id"], PROVIDERS_CONFIG["flaker"]["secret"], :site => "http://api.flaker.pl/" ) 
    access_token = OAuth::AccessToken.new(consumer, token, secret)
    return access_token
  end
end
