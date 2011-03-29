class Update < ActiveRecord::Base
  belongs_to :user
  has_many :links, :dependent => :destroy
  
  after_create :build_links
  
  def build_links
    self.user.social_accounts.all.each do |sa|
      self.links.create(:social_account_id => sa.id)
    end
  end
  
  def to_twitter
    tags = self.tags.split(",").map { |tag| "#"+tag.strip }.join(", ")
    [self.title, self.url, tags].compact.join(" ").strip
  end
  
  def to_facebook
    {
      :message => self.body,
      :link => self.url,
      :caption => self.title,
      :title => self.title,
      :description => self.body
    }
  end
  
end
