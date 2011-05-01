class FacebookPhotoPublish < StreamPublish
  def perform

  end
  
  def upload_picture(photo)
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)
    
    resp = graph.put_picture(photo.image.path, link.uid)
  end
end

