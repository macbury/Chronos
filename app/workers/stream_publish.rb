class StreamPublish < Struct.new(:link_id)
  def link
    @link ||= Link.find(link_id)
    @link
  end
  
  def progress(done)
    link.progress = done
    link.save
    
    self.notify(link.to_json)
  end
  
  def status(new_type,text=nil)
    link.status_type = new_type
    link.status_message = text
    link.save
    
    self.notify(link.to_json)
  end
  
  def notify(data)
    message = { :channel => "/#{link.stream.user.api_token}/notifications/links", :data => notify }
    uri = URI.parse(RhCore::Config["faye_server"])
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
  
  def before(job)
    status(Link::Working)
  end

  def perform
    throw "Setup Perform Action"
  end

  def success(job)
    status(Link::Success)
  end

  def error(job, exception)
    status(Link::Error)
  end

  def failure
    status(Link::Failure)
  end
end

