class Track < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :name, :on => :create, :message => "Je moet wel een naam invoeren"
  validates_presence_of :mp3_file_name, :on => :create, :message => "Je moet een mp3 bijvoegen"
  has_attached_file :mp3 
  
end
