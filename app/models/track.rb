class Track < ActiveRecord::Base
  validates_presence_of :name, :message => "Je moet wel een naam invoeren"
  
  belongs_to :user
  
  #file attachment
  has_attached_file :mp3
end
