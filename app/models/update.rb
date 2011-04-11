class Update < ActiveRecord::Base
  include ActionController::UrlWriter
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper
  default_url_options[:host] = RhCore::Config["host"]
  
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
      return short_link_url(:id => short.id.to_s(32))
    end
  end

  def to_twitter
    tags = self.tags.split(",").map { |tag| "#"+tag.strip }.join(", ")
    [strip_tags(self.title), self.short_url, tags].compact.join(" ").strip
  end
  
  def to_flaker
    tags = self.tags.split(",").map { |tag| "#"+tag.strip }.join(", ")
    [strip_tags(self.title), tags, truncate(strip_tags(self.body), :length => 255)].compact.join("\n").strip
  end
  
  def image
    if body =~ /(http:\/\/.+\.(png|gif|jpg|jpeg))/i
      return $1
    end
  end
  
  def to_facebook
    out = {
      :message => truncate(strip_tags(self.body), :length => 255),
      :link => self.short_url,
      :caption => strip_tags(self.title),
      :title => strip_tags(self.title),
      :description => truncate(strip_tags(self.body), :length => 255)
    }
    
    out[:picture] = self.image if self.image.present?
    
    return out
  end
  
end
