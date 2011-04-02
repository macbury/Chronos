class Update < ActiveRecord::Base
  include ActionController::UrlWriter
  include ActionView::Helpers::TextHelper
  default_url_options[:host] = RhCore::Config["host"]
  
  belongs_to :user
  has_many :links, :dependent => :destroy
  
  after_create :build_links
  
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
    [self.title, self.short_url, tags].compact.join(" ").strip
  end
  
  def to_flaker
    tags = self.tags.split(",").map { |tag| "#"+tag.strip }.join(", ")
    [self.title, tags, truncate(self.body, :length => 255)].compact.join("\n").strip
  end
  
  def to_facebook
    {
      :message => truncate(self.body, :length => 255),
      :link => self.short_url,
      :caption => self.title,
      :title => self.title,
      :description => self.body
    }
  end
  
end
