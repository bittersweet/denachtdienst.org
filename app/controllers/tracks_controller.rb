class TracksController < ApplicationController
  def index
    @track = Track.find(:all)
    @user = User.find(params[:user_id])
  end

  def new
    @track = Track.new
  end

  def create
    @user = User.find(params[:user_id])
    
    @track = Track.new
    @track.name = params[:track][:name]
    @track.user_id = @user
    if @track.save
      flash[:notice] = "Track toevoeging gelukt"
      redirect_to :controller => "tracks", :action => "index"
    else
      flash[:notice] = "Je moet wel wat invoeren"
      render :action => 'new'
    end
  end
  
  def show
    @track = Track.find(params[:id])
  end
  
  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to :controller => "tracks", :action => "index"
    flash[:notice] = "Track verwijderd"
  end
  
end
