class UserSweeper < ActionController::Caching::Sweeper
  
  observe User
  
  def after_save(user)
    clear_users_cache(user)
  end
  
  def after_destroy(user)
    clear_users_cache(user)
  end
  
  def clear_users_cache(user)
    expire_page :controller => :users, :action => :show, :id => user

  end
  
end