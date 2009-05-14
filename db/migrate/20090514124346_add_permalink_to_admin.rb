class AddPermalinkToAdmin < ActiveRecord::Migration
  def self.up
    user = User.find_by_name("admin")
    user.save
  end

  def self.down
  end
end
