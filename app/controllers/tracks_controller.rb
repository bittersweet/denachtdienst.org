class TracksController < ApplicationController
  def index
    @track = Track.find(:all)
  end

  def new
    @track = Track.new
  end

  def create
    @user = User.find(params[:user_id])
    @user.tracks.create :name => params[:track][:name]
    redirect_to :controller => "tracks", :action => "index"
  end

end
