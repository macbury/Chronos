module RhCore
  Config = YAML.load_file(File.join([Rails.root, "config", "rhcore.yml"]))[Rails.env]
  Client = OAuth2::Client.new(RhCore::Config["app_id"], RhCore::Config["secret"], :site => RhCore::Config["site"])
end

ActionMailer::Base.default_url_options[:host] = "csk.rhmusic.pl"
