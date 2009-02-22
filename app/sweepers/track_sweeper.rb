class TrackSweeper < ActionController::Caching::Sweeper
  
  observe Track
  
  def after_save(track)
    clear_tracks_cache(track)
  end
  
  def after_destroy(track)
    clear_tracks_cache(track)
  end
  
  def clear_tracks_cache(track)
    expire_page :controller => :tracks, :action => :show, :id => track
    expire_page :controller => :tracks, :action => :index
    expire_page :controller => :users, :action => :show, :id => current_user.id
  end
  
end