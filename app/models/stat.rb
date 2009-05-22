class Stat < ActiveRecord::Base
  
  belongs_to :track
  
  validates_presence_of :browser, :on => :create
  validates_presence_of :ip, :on => :create

  def self.update_playcount(track_id, env)
    @track = Track.find(track_id)
    
    @track.stats.create(:ip => env["REMOTE_ADDR"],
                        :browser => env['HTTP_USER_AGENT'],
                        :played_at => Time.now)
  end
  
end
