class Stat < ActiveRecord::Base
  
  belongs_to :track
  
  validates_presence_of :browser, :on => :create
  validates_presence_of :ip, :on => :create

end
