require File.join([Rails.root, '/lib', '/oa_blip.rb'])
require File.join([Rails.root, '/lib', '/oa_flaker.rb'])
require File.join([Rails.root, '/lib', '/oa_myspace.rb'])
providers = YAML.load_file(File.join([Rails.root, "config", "providers.yml"]))[Rails.env]

PROVIDERS_CONFIG = providers

Rails.application.config.middleware.use OmniAuth::Builder do
  providers.each do |provider_name, config|
    if provider_name.to_sym == :facebook
      provider provider_name.to_sym, config['app_id'], config['secret'], { :scope => "manage_pages, offline_access, publish_stream" }
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
  
end