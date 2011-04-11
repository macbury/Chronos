class StreamPublish < Struct.new(:link_id)
  def link
    @link ||= Link.find(link_id)
  end
 
  def status(type,text=nil)
    link.update_attributes(:status_id => type, :status_message => text)
    uri = URI.parse(RhCore::Config["faye_server"])
    Net::HTTP.post_form(uri, :link => link.to_json)
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

