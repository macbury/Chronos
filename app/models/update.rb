class Update < ActiveRecord::Base

  belongs_to :user
  has_many :links, :dependent => :destroy
  
  after_create :build_links
  
  #validates :title, :presence => true
  
  def build_links
    self.user.social_accounts.all.each do |sa|
      self.links.create(:social_account_id => sa.id)
    end
  end
  
  def short_url
    unless (url.nil? || url.empty?)
      short = user.short_links.find_or_create_by_url(url)
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
