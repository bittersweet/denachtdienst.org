class ArtistsController < ApplicationController

  before_filter :login_required

  def index
    
    if logged_in?
      @profile = current_user
    end
    
    @artist = Time.now
  end

end
