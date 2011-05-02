class PhotoUpload < Struct.new(:photo_id, :link_id)
  def link
    @link ||= Link.find(link_id)
    @link
  end
  
  def photo
    @photo ||= Photo.find(photo_id)
    @photo
  end

  def perform
    throw "Setup Perform Action"
  end

  def success(job)
    link.done += 1
    link.progress = (link.done * 100 / link.total).round
    link.save
    
    message = { :channel => "/#{link.stream.user.api_token}/notifications/links", :data => link.to_json }
    uri = URI.parse(RhCore::Config["faye_server"])
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end

