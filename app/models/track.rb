class Track < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :mp3 
  
  validates_presence_of :name, :on => :create, :message => "Je moet wel een naam invoeren"
  validates_presence_of :mp3_file_name, :on => :create, :message => "Je moet een mp3 bijvoegen"
  validates_attachment_content_type :mp3, :content_type => ['audio/mpeg'], :message => "Je mag alleen mp3's uploaden"
  
end
