class FacebookAlbumPublish < StreamPublish
  def perform
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)

    resp = graph.put_object(link.social_account.uid, "albums", link.stream.streamable.to_facebook)
    if resp["id"]
      link.uid = resp["id"]
      link.save
    end
  end
end

