require "rails_helper"

describe Receipt do
  it { is_expected.to belong_to(:user) }

  describe ".for_payload" do
    it "returns the receipts matching the given payload" do
      receipt = create(:receipt, token: "abc")
      _another_receipt = create(:receipt, token: "123")

      expect(Receipt.for_payload(token: "abc")).to eq [receipt]
    end
  end
end
