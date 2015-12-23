class Receipt < ActiveRecord::Base
  belongs_to :user

  enum environment: {
    production: 0,
    sandbox: 1,
  }

  def self.for_payload(payload)
    where(payload)
  end
end
