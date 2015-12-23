require "spec_helper"

describe AppleReceipt do
  describe ".endpoint_url" do
    context "given sandbox parameters" do
      it "returns the sandbox url" do
        result = AppleReceipt.endpoint_url(sandbox: "1")

        expect(result).to eq AppleReceipt::SANDBOX_URL
      end
    end

    context "given non-sandbox parameters" do
      it "returns the production url" do
        result = AppleReceipt.endpoint_url({})

        expect(result).to eq AppleReceipt::RECEIPT_URL
      end
    end
  end

  describe ".environment" do
    context "given sandbox parameters" do
      it "returns sandbox" do
        result = AppleReceipt.environment(sandbox: "1")

        expect(result).to eq "sandbox"
      end
    end

    context "given non-sandbox parameters" do
      it "returns production" do
        result = AppleReceipt.environment({})

        expect(result).to eq "production"
      end
    end
  end
end
