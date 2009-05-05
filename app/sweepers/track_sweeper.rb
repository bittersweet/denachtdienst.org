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
    
    expire_page :controller => :tracks, :action => :show, :id => track
    expire_page '/index.html'
    expire_page :controller => :users, :action => :show, :id => @loggedinuser
    expire_page :controller => :tracks, :action => :rss
  end
  
end