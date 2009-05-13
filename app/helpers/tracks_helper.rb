module TracksHelper
  
  def create_track_path_with_session_information
    session_key = ActionController::Base.session_options[:session_key]
    tracks_path(session_key => cookies[session_key], request_forgery_protection_token => form_authenticity_token)
  end
  
end
