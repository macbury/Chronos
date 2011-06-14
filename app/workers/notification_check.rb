class NotificationCheck < Struct.new(:link_id)

  def link
    @link ||= Link.find(link_id)
    @link
  end
  
  def notify(data)
    message = { :channel => "/#{link.stream.user.api_token}/notifications", :data => data }
    uri = URI.parse(RhCore::Config["faye_server"])
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

  def perform
    throw "Setup Perform Action"
  end 
  
end

