class UsersController < ApplicationController
  
  protect_from_forgery :only => [:create, :update, :destroy] 
  
  caches_page :show, :index
  
  cache_sweeper :user_sweeper,
                :only => [:update, :destroy]  
  
  before_filter :login_required, :only => [ :edit, :update, :manage, :profile ]  
  
  def index
    @user = User.find(:all, :order => "name ASC")
  end
  
  def show
    if User.exists?(:permalink => params[:id])
      @user = User.find_by_permalink(params[:id])
      @track = @user.tracks.reverse
    else
      rescue_404
    end
  end
  
  def profile
    @user = current_user
  end
  
  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
  
    if @user.update_attributes(params[:user])
      redirect_to profile_users_path
    else
      render "edit" 
    end
  end

  def manage
    
    @track = Track.find(:all, :include => [ :user, :stats ] )
    
    #   
    # @user = User.find(current_user.id)
    # @track = Track.find(:all, :conditions => "user_id = 1", :include => :stats)
    # # @track = @user.tracks.reverse

  end
  
  def status
    render :partial => "status"
  end

  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      self.current_user = @user # !! now logged in
      redirect_to profile_users_path
      flash[:notice] = "Je bent geregistreerd."
    else
      flash[:error]  = "Het ging niet helemaal goed..."
      render "new"
    end
  end
  
end
