module TracksHelper
  
  def new_track_path_with_session_information
    session_key = config.action_controller.session_options[:session_key]
    new_track_path(session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token)
  end
  
end
