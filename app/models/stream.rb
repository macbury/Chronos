class Stream < ActiveRecord::Base
  belongs_to :user
  has_many :links, :dependent => :destroy
  has_many :reactions, :dependent => :destroy
  belongs_to :streamable, :polymorphic => true

  after_create :build_links

  def build_links
    self.user.social_accounts.for_types(streamable.send_to).all.each do |sa|
      self.links.create(:social_account_id => sa.id)
    end
  end

  def serializable_hash(options = {})
    defaults = {:only => [:id, :streamable_type, :streamable, :streamable_id, :created_at]}
    if options.nil?
      options = defaults
    else
      options.merge!(defaults)
    end
    super(options)
  end
end

