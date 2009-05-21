class TrackSweeper < ActionController::Caching::Sweeper
  
  observe Track
  
  def after_save(track)
    clear_tracks_cache(track)
  end
  
  def after_destroy(track)
    clear_tracks_cache(track)
  end
  
  def clear_tracks_cache(track)
    
    if current_user.nil?
      @loggedinuser = "1"
    else
      @loggedinuser = current_user.id
    end
    
    @user = User.find(@loggedinuser)
    
    expire_page :controller => :tracks, :action => :show, :id => track
    expire_page :controller => :tracks, :action => :index
    expire_page :controller => :users, :action => :show, :id => @user.permalink
    expire_page :controller => :tracks, :action => :rss
    expire_page '/index.html'
  end
  
end