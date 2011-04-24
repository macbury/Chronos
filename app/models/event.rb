class Event < ActiveRecord::Base
  PublishTo = [SocialAccount::Facebook, SocialAccount::MySpace, SocialAccount::LastFm, SocialAccount::Muzzo]

  has_one :stream, :as => :streamable
  
  attr_accessor :image
  before_create :assign_image
  
  has_attached_file :flayer, :styles => { :original => "620x440>", :thumb => "43x60>" }
  validates_attachment_size :flayer, :less_than => 5.megabytes
  validates_attachment_content_type :flayer, :content_type => ['image/jpeg', 'image/png', 'image/jpg']

  def serializable_hash(options = {})
    defaults = { :methods => [:thumb], :only => [:title, :description, :start_date, :end_date, :where, :id] }
    if options.nil?
      options = defaults
    else
      options.merge!(defaults)
    end
    super(options)
  end
  
  def thumb
    flayer.url(:thumb)
  end
  
  def send_to
    Event::PublishTo
  end

  def to_facebook
    out = {
      :name => self.title,
      :description => description,
      :start_time => Event.prepareFBTime(start_date).to_time.xmlschema,
      :end_time => Event.prepareFBTime(end_date).to_time.xmlschema,
      :location => self.where,
    }
    
    unless self.flayer.path(:original).nil? 
      picture = Koala::UploadableIO.new(self.flayer.path(:original))
      out[:picture] = picture
    end
    
    return out
  end

  def self.prepareFBTime(time)
    time + 7.hours
  end
  
  def assign_image
    begin
      Rails.logger.info "Setting file for flayer: #{self.image}"
      file = File.open(File.join([Rails.root, "tmp/uploads/"+self.image]), "r")
      self.flayer = file
    rescue Exception => e
      Rails.logger.info e.to_s
    end
  end
end

