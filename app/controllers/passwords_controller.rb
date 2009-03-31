class PasswordsController < ApplicationController
	before_filter :login_required

  def index
  end

  # Change user password
  def change_password_update
    if User.authenticate(current_user.login, params[:old_password])
      if ((params[:password] == params[:password_confirmation]) && !params[:password_confirmation].blank?)
        current_user.password_confirmation = params[:password_confirmation]
        current_user.password = params[:password]

        if current_user.save
          flash[:notice] = "Password successfully updated"
          redirect_to profile_users_path
        else
          flash[:notice] = "Password not changed"
          render 'index'
        end
   
      else
        flash[:notice] = "New Password mismatch" 
        render 'index'
      end
    else
      flash[:notice] = "Old password incorrect" 
      render 'index'
    end
  end

end

