require "rails_helper"

describe Receipt do
  it { is_expected.to belong_to(:user) }

  describe ".create_from_apple_payload" do
    it "massages the payload from Apple" do
      user = create(:user)
      payload = JSON.
        parse(fixture_for("receipt-response.json")).
        merge("data" => "data", "token" => "token")

      receipt = user.receipts.create_from_apple_payload(payload)

      expected_payload = payload["receipt"].
        slice(*Receipt::APPLE_METADATA_KEY_WHITELIST)
      expect(receipt.metadata).to eq expected_payload
    end
  end
end
