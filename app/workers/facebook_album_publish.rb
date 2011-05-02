class FacebookAlbumPublish < StreamPublish
  def perform
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)

    resp = graph.put_object(link.social_account.uid, "albums", link.stream.streamable.to_facebook)
    if resp["id"]
      link.uid = resp["id"]

      photos = link.stream.streamable.photos.all
      link.total = photos.size
      link.done = 0
      
      link.save
      
      photos.each do |photo|
        Delayed::Job.enqueue FacebookPhotoPublish.new(photo.id, link.id), TaskPriority::Photo, 1.seconds.from_now
      end
    end
  end

end

