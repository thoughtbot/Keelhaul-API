class User < ActiveRecord::Base
  include Clearance::User

  before_save :generate_token

  private

  def generate_token
    self.token ||= SecureRandom.urlsafe_base64
  end
end
