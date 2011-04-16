class LastfmStreamPublish < StreamPublish
  def perform
    lastfm = LastFm.new(link.social_account.login, link.social_account.password)
    lastfm.publish_on_wall(link.social_account.name, link.owner.to_lastfm)
  end
end
