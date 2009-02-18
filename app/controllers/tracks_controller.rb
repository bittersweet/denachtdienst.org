class TracksController < ApplicationController
  def index
    @track = Track.find(:all)
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
      
        # 
        # @user.tracks.create :name => params[:track][:name]
        # if @user.tracks.create
        #   flash[:notice] = "Track toevoeging gelukt"
        #   redirect_to :controller => "tracks", :action => "index"
        # else
        #   flash[:notice] = "Het is niet gelukt"
        #   render :action => 'new'
        # end
  end

end
