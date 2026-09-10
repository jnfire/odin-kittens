class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def generate_auth_token!
    token = SecureRandom.hex(32)
    update!(
      auth_token_digest: Digest::SHA256.hexdigest(token),
      auth_token_created_at: Time.current
    )
    token
  end

  def clear_auth_token!
    update!(
      auth_token_digest: nil,
      auth_token_created_at: nil
    )
  end

  def self.authenticate_with_token(token)
    digest = Digest::SHA256.hexdigest(token)
    find_by(auth_token_digest: digest)
  end
end
