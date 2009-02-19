class AddMp3ToTracks < ActiveRecord::Migration
  def self.up
    add_column :tracks, :mp3, :string
  end

  def self.down
    remove_column :tracks, :mp3
  end
end
