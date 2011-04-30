class FacebookPhotoPublish < StreamPublish
  def perform
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)

    resp = graph.put_object(link.social_account.uid, "albums", link.stream.streamable.to_facebook)
    if resp["id"]
      link.uid = resp["id"]
      link.save
      
      photos = link.stream.streamable.photos.all
      total = photos.size
      done = 0
      
      photos.each do |photo|
        begin
          self.upload_picture(photo)
          done += 1
          self.progress((done * 100 / total).round)
        rescue Exception => e
        
        end
      end
    end
  end
  
  def upload_picture(photo)
    graph = Koala::Facebook::GraphAPI.new(link.social_account.token)
    
    resp = graph.put_picture(photo.image.path, link.uid)
  end
end

