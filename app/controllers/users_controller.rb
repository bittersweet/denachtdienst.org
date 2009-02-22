class UsersController < ApplicationController

  protect_from_forgery :only => [:create, :update, :destroy] 
  
  caches_page :show
  
  def show
    @track = Track.find(:all, :conditions => { :user_id => params[:id]})
    @user = User.find(params[:id])
  end
  
  def manage
    @track = Track.find(:all, :conditions => { :user_id => current_user.id})
    @user = User.find(current_user.id)
  end
  
  def status
    render :partial => 'users/status/'
  end

  # render new.rhtml
  def new
    @user = User.new
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
      render :action => 'new'
    end
  end
  
end
