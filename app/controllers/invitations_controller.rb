class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      flash[:notice] = "Successfully created invitation."
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
end
