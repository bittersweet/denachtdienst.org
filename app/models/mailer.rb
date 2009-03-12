class Mailer < ActionMailer::Base

  def invitation(invitation, signup_url)
    subject     'Uitnodiging voor denachtdienst.org'
    recipients  invitation.recipient_email
    from        'mark@denachtdienst.org'
    body        :invitation => invitation, :signup_url => signup_url
    invitation.update_attribute(:sent_at, Time.now)
  end

end
