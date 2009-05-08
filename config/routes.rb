ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.signup '/signup/:invitation_token', :controller => 'users', :action => 'new'
  map.edit_profile '/users/profile/edit', :controller => 'users', :action => 'edit'
  map.change_password '/change_password', :controller => 'passwords', :action => 'index'
  map.resources :users, :has_many => :tracks, :collection => { :profile => :get, :manage => :get }
  map.resources :tracks
  map.playcount '/tracks/:id/playcount', :controller => 'tracks', :action => 'raise_playcount'
  map.resource :session
  map.resources :invitations
  map.root :controller => 'tracks'

  #rss feeds
  map.rss '/rss', :controller => 'tracks', :action => 'rss'
  map.userrss '/users/:id/rss', :controller => 'tracks', :action => 'userrss'

  #logged in status
  map.status '/status', :controller => 'users', :action => 'status'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  map.error '*path', :controller => 'application', :action => 'rescue_404'

end
