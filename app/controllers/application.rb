# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time


  # has to be a class method so I can call it from every page
  # Can maybe be turned into a helper method
  # http://api.rubyonrails.org/classes/ActionController/Helpers/ClassMethods.html
  def self.logged_in?
    @profile = current_user
  end

  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem
  
  #this override redirects the user to /login instead of /session/new
  def access_denied
    alias new_session_path login_path
    super
  end

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'a45e3e72714cdd7363a0c8954c6b841c'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  filter_parameter_logging :password
end
