module MockAppleReceipt
  def with_fake_apple_receipt(options = {})
    default_options = {
      status: 0,
      url: AppleReceipt.endpoint_url,
      file: "spec/support/fixtures/receipt-response.json",
    }
    options = default_options.merge(options)
    body = JSON.parse(File.read(options[:file]))

    request_stub = stub_request(
      :post,
      options[:url],
    ).to_return(
      body: body.merge(status: options[:status]).to_json,
      status: 200,
    )

    yield

    remove_request_stub(request_stub)
  end
end

RSpec.configure do |config|
  config.include MockAppleReceipt
end
