class FacebookStreamPublish < StreamPublish
  def perform
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)

    resp = graph.put_object(link.social_account.uid, "feed", link.stream.streamable.to_facebook)
    if resp["id"]
      link.uid = resp["id"]
      link.save
      
      Delayed::Job.enqueue FacebookStatusNotification.new(link.id), TaskPriority::Notification, TaskFrequency.from_now
    end
  end
end

