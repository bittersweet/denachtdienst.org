class Playcount < ActiveRecord::Migration
  def self.up
    add_column :tracks, :playcount, :int
  end

  def self.down
    remove_column :tracks, :playcount
  end
end
