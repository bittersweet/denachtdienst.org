class Invitation < ActiveRecord::Base
  
  belongs_to :sender, :class_name => "User"
  has_one :recipient, :class_name => "User"
  
  validates_presence_of :recipient_email, :message => "Je bent een e-mail adres vergeten in te voeren"
  validate :recipient_is_not_registered, :message => "Dit e-mail adres is al geregistreerd"
  
  before_create :generate_token
  
private

  def recipient_is_not_registered
    errors.add :recipient_email, 'This user is already registered' if User.find_by_email(recipient_email)
  end
  
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  
end
