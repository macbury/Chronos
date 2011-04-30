class Album < ActiveRecord::Base
  PublishTo = [SocialAccount::Facebook, SocialAccount::MySpace, SocialAccount::LastFm]

  has_one :stream, :as => :streamable
  has_many :photos, :dependent => :destroy
  
  attr_accessor :raw_photos
  
  after_create :assign_images
  
  def send_to
    Album::PublishTo
  end
  
  def assign_images
    if self.raw_photos
      self.raw_photos.each do |photo|
        begin
          file = File.open(File.join([Rails.root, "tmp/uploads/"+photo]), "r")
          self.photos.create(:image => file)
        rescue Exception => e
          Rails.logger.info e.to_s
        end
      end
    end
  end
  
  def preview
    self.photos.limit(18).map { |photo| { :thumb => photo.image.url(:thumb), :original => photo.image.url(:original) } }
  end
  
  def serializable_hash(options = {})
    defaults = { :methods => [:preview], :only => [:title, :description, :id] }
    if options.nil?
      options = defaults
    else
      options.merge!(defaults)
    end
    super(options)
  end
  
  def to_facebook
    { :title => self.title, :description => self.description }
  end
end
