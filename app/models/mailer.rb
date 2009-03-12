class Mailer < ActionMailer::Base
  

  def invitation(sent_at = Time.now)
    subject    'Mailer#invitation'
    recipients ''
    from       ''
    sent_on    sent_at
    
    body       :greeting => 'Hi,'
  end

end
