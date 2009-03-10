class TracksController < ApplicationController

  caches_page :index, :show, :rss

  cache_sweeper :track_sweeper,
                :only => [:create, :update, :destroy]

  #Only need to login if you want to create a new track
  before_filter :login_required, :only => [ :new, :destroy ]

  def index
      @track = Track.find(:all, :include => "user")
      @user = @track.collect {|x| x.user}.uniq
  end

  def new
    @track = Track.new
  end

  def create
    #  @user = User.find(params[:user_id])
    @user = current_user
    @track = Track.new
    @track.name = params[:track][:name]
    @track.mp3 = params[:track][:mp3]
    @track.user_id = @user.id
    if @track.save
      flash[:notice] = "Track toevoeging gelukt"
      redirect_to :controller => "users", :action => "manage"
    else
      render :action => 'new'
    end
  end
  
  def show
      @track = Track.find(params[:id])
  end

  def edit
    @track = Track.find(params[:id])
    @user = current_user
    
    if @track.user_id != @user.id
      redirect_to root_path
    end
  end

  def update
    @track = Track.find(params[:id])

    if @track.update_attributes(params[:track])
      redirect_to track_path(params[:id])
    else
      render :action => "edit" 
    end
  end
  
  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to :back
    flash[:notice] = "Track verwijderd"
  end
  
  def rss
    @track = Track.find(:all, :order => "id DESC", :limit => "30")
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
end
