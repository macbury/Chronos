class Update < ActiveRecord::Base
  PublishTo = [SocialAccount::Facebook, SocialAccount::Twitter, SocialAccount::Blip, SocialAccount::Flaker, SocialAccount::MySpace, SocialAccount::LastFm]
  
  belongs_to :user
  has_one :stream, :as => :streamable
  
  def send_to
    Status::PublishTo
  end
  
  def serializable_hash(options = {})
    defaults = {:only => [:id, :body, :created_at, :title]}
    if options.nil?
      options = defaults
    else
      options.merge!(defaults)
    end
    super(options)
  end
  
  def short_url
    unless (url.nil? || url.empty?)
      short = stream.user.short_links.find_or_create_by_url(url)
      return ModelHelper.short_link_url(:id => short.id.to_s(32))
    end
  end

  def to_twitter
    tags = self.tags.split(",").map { |tag| "#"+tag.strip }.join(", ")
    [ModelHelper.strip_tags(self.title), self.short_url, tags].compact.join(" ").strip
  end
  
  def to_flaker
    tags = self.tags.split(",").map { |tag| "#"+tag.strip }.join(", ")
    [ModelHelper.strip_tags(self.title), tags, ModelHelper.truncate(ModelHelper.strip_tags(self.body), :length => 255)].compact.join("\n").strip
  end
  
  def to_lastfm
    [ModelHelper.strip_tags(self.title), self.short_url].compact.join("\n").strip
  end

  def to_myspace
    to_lastfm
  end
  
  def image
    if body =~ /(http:\/\/.+\.(png|gif|jpg|jpeg))/i
      return $1
    end
  end
  
  def to_facebook
    content = self.body.present? ? self.body : self.title
    out = {
      :message => ModelHelper.truncate(ModelHelper.strip_tags(content), :length => 255)
    }
    
    out[:picture] = self.image if self.image.present?
    
    if self.short_url
      out[:link] = self.short_url
      out[:caption] = ModelHelper.strip_tags(self.title)
      out[:title] = ModelHelper.strip_tags(self.title)
      out[:description] = ModelHelper.truncate(ModelHelper.strip_tags(self.body), :length => 255)
    end
    return out
  end
  
end
