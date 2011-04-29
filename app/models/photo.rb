class Photo < ActiveRecord::Base
  belongs_to :album
  
  has_attached_file :image, :styles => { :original => "480x360>", :thumb => "75x75#" },
                            :url  => "/albums/:style/:id.:extension",
                            :path => ":rails_root/public/albums/:style/:id.:extension"
                            
  validates_attachment_size :image, :less_than => 5.megabytes
  validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png', 'image/jpg']
end
