require 'mime/types'

class Track < ActiveRecord::Base
  belongs_to :user
  
  has_attached_file :mp3 
  
  validates_presence_of :name, :message => "Je moet wel een naam invoeren"
  validates_attachment_presence :mp3, :message => "Je moet een mp3 bijvoegen"
  validates_attachment_content_type :mp3, :content_type => ['audio/mpeg'], :message => "Je mag alleen mp3's uploaden"

  # Fix the mime types. Make sure to require the mime-types gem
  def swfupload_file=(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.mp3 = data
  end
  
end
