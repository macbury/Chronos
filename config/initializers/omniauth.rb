require File.join([Rails.root, '/lib', '/oa_blip.rb'])
require File.join([Rails.root, '/lib', '/oa_flaker.rb'])
require File.join([Rails.root, '/lib', '/oa_myspace.rb'])
providers = YAML.load_file(File.join([Rails.root, "config", "providers.yml"]))[Rails.env]
Rails.application.config.middleware.use OmniAuth::Builder do
  providers.each do |provider_name, config|
    if provider_name.to_sym == :facebook
      provider provider_name.to_sym, config['app_id'], config['secret'], { :scope => "manage_pages, offline_access" }
    else
      provider provider_name.to_sym, config['app_id'], config['secret']
    end
  end
end