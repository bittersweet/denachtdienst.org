class ArtistsController < ApplicationController

  before_filter :login_required

  def index
    @artist = Time.now
  end

end
