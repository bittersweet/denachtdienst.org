class DeleteArtists < ActiveRecord::Migration
  def self.up
    drop_table :artists
  end

  def self.down
    create_table "artists", :force => true do |t|
      t.string   "name"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    
  end
end
