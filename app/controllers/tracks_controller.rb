class TracksController < ApplicationController

  caches_page :index, :show, :rss

  cache_sweeper :track_sweeper,
                :only => [:create, :update, :destroy]

  #Only need to login if you want to create a new track
  before_filter :login_required, :only => [ :new, :destroy ]

  def index
      @track = Track.find(:all, :order => "id DESC")
      @user = User.all
  end

  def new
    @track = Track.new
  end

  def create
    
    if current_user.nil?
      @loggedinuser = "1"
    else
      @loggedinuser = current_user.id
    end

    @track = Track.new
    @track.name = params[:track][:name]
    @track.mp3 = params[:track][:mp3]
    @track.user_id = @loggedinuser
    if @track.save
      flash[:notice] = "Track toevoeging gelukt"
      # twitter_update("[DND] Nieuwe track: " + @track.name + " (http://www.denachtdienst.org)")
      redirect_to :controller => "users", :action => "manage"
    else
      render "new"
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
      render "edit" 
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
  
  def userrss
    @user = User.find_by_permalink(params[:id])
    @track = Track.find(:all, :conditions => "user_id = #{@user.id}")
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end

  # posts the message to twitter
  def twitter_update(message)
    
    # AppConfig.twitter.user
    Twitter::Base.new(AppConfig.twitter.user, AppConfig.twitter.password).update(message)
  end

end
