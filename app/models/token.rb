class Token < ActiveRecord::Base
  TOKEN_LIFE_TIME = 30.days
  belongs_to :user
  validates_uniqueness_of :token

  before_create :set_expiration, :set_token

  def set_expiration
    self.expires_at = Time.now + TOKEN_LIFE_TIME
  end

  def set_token
    loop do
      self.token = SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
      break unless Token.find_by_token(self.token)
    end
  end

  def expired?
    expires_at < Time.now
  end
end
