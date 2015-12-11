class Receipt < ActiveRecord::Base
  belongs_to :user

  def self.for_payload(payload)
    where(payload)
  end
end
