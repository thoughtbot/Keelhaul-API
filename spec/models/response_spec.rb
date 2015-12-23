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

    context "given a status of 21003" do
      it "returns a UnauthenticatedError" do
        json = { "status" => 21_003 }

        result = Response.for(json)

        expect(result).to be_a Response::UnauthenticatedError
        expect(result.as_json).to eq({})
      end
    end

    context "given a status of any other" do
      it "returns a BadRequestError" do
        json = { "status" => 42 }

        result = Response.for(json)

        expect(result).to be_a Response::BadRequestError
        expect(result.as_json).to eq({})
      end
    end
  end
end
