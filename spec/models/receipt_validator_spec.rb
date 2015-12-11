require "rails_helper"

describe ReceiptValidator do
  describe "#validate" do
    context "when the receipt has not been validated" do
      context "when Apple receipt is valid" do
        it "is a success" do
          with_fake_apple_receipt(status: 0) do
            user = stubbed_user
            validator = ReceiptValidator.new(payload: {}, user: user)

            validation = validator.validate

            expect(validation.http_status).to eq 200
            expect(validation).to be_valid
          end
        end

        it "creates a receipt" do
          with_fake_apple_receipt(status: 0) do
            user = stubbed_user
            payload = {
              data: "data",
              token: "token",
            }
            validator = ReceiptValidator.new(payload: payload, user: user)

            validator.validate

            expect(user.receipts).to have_received(:create).with(payload)
          end
        end
      end

      context "when Apple receipt is unauthenticated" do
        it "is unauthenticated" do
          with_fake_apple_receipt(status: 21_003) do
            user = stubbed_user
            validator = ReceiptValidator.new(payload: {}, user: user)

            validation = validator.validate

            expect(validation.http_status).to eq 403
            expect(validation).not_to be_valid
          end
        end
      end

      context "when Apple receipt is otherwise invalid" do
        it "is a bad request" do
          with_fake_apple_receipt(status: 21_000) do
            user = stubbed_user
            validator = ReceiptValidator.new(payload: {}, user: user)

            validation = validator.validate

            expect(validation.http_status).to eq 400
            expect(validation).not_to be_valid
          end
        end
      end
    end

    context "when the receipt has been validated before" do
      context "when the token matches" do
        it "is a success" do
          user = stubbed_user
          receipt = double("Receipt", token: "abc123")
          payload = {
            data: "data",
            token: "abc123",
          }
          allow(user.receipts).to receive(:find_by).and_return(receipt)
          validator = ReceiptValidator.new(payload: payload, user: user)

          validation = validator.validate

          expect(validation).to be_valid
          expect(user.receipts).to have_received(:find_by).with(data: "data")
        end
      end

      context "when the token does not match" do
        it "is a bad request" do
          user = stubbed_user
          receipt = double("Receipt", token: "abc123")
          payload = {
            data: "data",
            token: "321cba",
          }
          allow(user.receipts).to receive(:find_by).and_return(receipt)
          validator = ReceiptValidator.new(payload: payload, user: user)

          validation = validator.validate

          expect(validation).not_to be_valid
        end
      end
    end
  end

  def stubbed_user(options = {})
    default_options = {
      receipts: double("ReceiptsForUser", create: nil, find_by: nil),
    }

    double("User", default_options.merge(options))
  end
end
