class AddFirstAdminUser < ActiveRecord::Migration
  def self.up
		#Be sure to change these settings for your initial admin user
    user = User.new
		user.login = "admin"
		user.name = "admin"
		user.email = "markmulder@gmail.com"
		user.password = "password"
		user.password_confirmation = "password"
		user.permalink = "admin"
		user.avatar_file_name = "null.jpg"
		user.avatar_content_type = "image/jpeg"
		user.avatar_file_size = "1"
    user.save(false)
		role = Role.new
		#Admin role name should be "admin" for convenience
		role.name = "admin"
		role.save
		admin_user = User.find_by_login("admin")
		admin_role = Role.find_by_name("admin")
		admin_user.roles << admin_role
		admin_user.save(false)		
  end

  def self.down
		admin_user = User.find_by_login("admin")
		admin_role = Role.find_by_name("admin")
		admin_user.roles = []
    admin_user.save
    admin_user.destroy
		admin_role.destroy
  end
end
