class CreateStats < ActiveRecord::Migration
  def self.up
    create_table :stats do |t|
      t.column :track_id, :integer
      t.column :ip,       :string
      t.column :browser,  :string
      t.column :played_at,     :datetime
    end
  end

  def self.down
    drop_table :stats
  end
end
