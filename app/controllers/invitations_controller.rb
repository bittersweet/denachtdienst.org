class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.sender = current_user
    if @invitation.save
      Mailer.deliver_invitation(@invitation, signup_url(@invitation.token))
      flash[:notice] = "Successfully created invitation."
      redirect_to root_path
    else
      render :action => 'new'
    end
  end
end
