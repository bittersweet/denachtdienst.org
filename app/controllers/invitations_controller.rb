class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    if @invitation.save
      flash[:notice] = "Successfully created invitation."
      redirect_to invitations_url
    else
      render :action => 'new'
    end
  end
end
