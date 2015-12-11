class AppleReceipt
  RECEIPT_URL = ENV.fetch("APPLE_RECEIPT_ENDPOINT")
  SANDBOX_URL = ENV.fetch("APPLE_SANDBOX_ENDPOINT")

  def self.endpoint_url(params = {})
    if params[:sandbox] == "1"
      SANDBOX_URL
    else
      RECEIPT_URL
    end
  end
end
