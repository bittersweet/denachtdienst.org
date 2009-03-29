class UsersController < ApplicationController
  
  protect_from_forgery :only => [:create, :update, :destroy] 
  
  caches_page :show
  
  cache_sweeper :user_sweeper,
                :only => [:update, :destroy]  
  
  before_filter :login_required, :only => [ :edit, :update, :manage, :profile ]  
  
  def show
    if User.exists?(:permalink => params[:id])
      @user = User.find_by_permalink(params[:id])
      @track = Track.find(:all, :conditions => { :user_id => @user.id})
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
    @track = Track.find(:all, :conditions => { :user_id => current_user.id})
    @user = User.find(current_user.id)
  end
  
  def status
    render :partial => "status"
  end

  # render new.rhtml
  def new
    @user = User.new(:invitation_token => params[:invitation_token])
    @user.email = @user.invitation.recipient_email if @user.invitation
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Je bent geregistreerd."
    else
      flash[:error]  = "Het ging niet helemaal goed..."
      render "new"
    end
  end
  
end
