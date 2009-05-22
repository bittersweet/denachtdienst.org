class RemovePlaycountFromTracks < ActiveRecord::Migration
  def self.up
    remove_column :tracks, :playcount
  end

  def self.down
    add_column :tracks, :playcount, :integer,        :default => 0
  end
end
