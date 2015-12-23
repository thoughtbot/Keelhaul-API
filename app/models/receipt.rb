class Receipt < ActiveRecord::Base
  APPLE_METADATA_KEY_WHITELIST = %w(
    application_version
    bundle_id
    download_id
    original_purchase_date_ms
    receipt_creation_date_ms
    request_date_ms
  ).freeze

  belongs_to :user

  enum environment: {
    production: 0,
    sandbox: 1,
  }

  def self.create_from_apple_payload(payload)
    new_payload = {
      data: payload["data"],
      token: payload["token"],
      metadata: payload["receipt"].slice(*APPLE_METADATA_KEY_WHITELIST),
    }

    create(new_payload)
  end
end
