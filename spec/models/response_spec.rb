require "spec_helper"
require "app/models/response"

describe Response do
  describe ".for" do
    context "given a status of 0" do
      it "returns a SuccessfulRequest" do
        json = { "status" => 0 }

        result = Response.for(json)

        expect(result).to be_a Response::SuccessfulRequest
      end
    end

    context "given a status of 21003" do
      it "returns a UnauthenticatedError" do
        json = { "status" => 21_003 }

        result = Response.for(json)

        expect(result).to be_a Response::UnauthenticatedError
      end
    end

    context "given a status of any other" do
      it "returns a BadRequestError" do
        json = { "status" => 42 }

        result = Response.for(json)

        expect(result).to be_a Response::BadRequestError
      end
    end
  end
end
