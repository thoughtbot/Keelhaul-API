require "rails_helper"

describe Response do
  describe ".for" do
    context "given a status of 0" do
      it "returns a SuccessfulRequest" do
        apple_receipt = JSON.parse(fixture_for("receipt-response.json"))
        json = apple_receipt.merge("status" => 0)
        expected_json = apple_receipt["receipt"].
          slice(*Receipt::APPLE_METADATA_KEY_WHITELIST)

        result = Response.for(json)

        expect(result).to be_a Response::SuccessfulRequest
        expect(result.as_json).to eq(expected_json)
      end
    end

    context "given a status of 21007" do
      it "returns a BadRequestError" do
        json = { "status" => 21_007 }

        result = Response.for(json)

        expect(result).to be_a Response::BadRequestError
        expect(result.as_json).to eq("status" => 21_007)
      end
    end

    context "given a status of any other" do
      it "returns a BadRequestError" do
        json = { "status" => 42 }

        result = Response.for(json)

        expect(result).to be_a Response::BadRequestError
        expect(result.as_json).to eq("status" => 42)
      end
    end
  end
end
