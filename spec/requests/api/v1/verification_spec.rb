require "rails_helper"

describe "Verification of the Apple receipt" do
  context "valid receipt, known API key, unknown token" do
    it "is a success" do
      with_fake_apple_receipt do
        user = create(:user)
        receipt_data =
          JSON.parse(fixture_for("receipt-response.json"))["receipt"]
        expected_json =
          receipt_data.slice(*Receipt::APPLE_METADATA_KEY_WHITELIST)

        auth_post(
          api_v1_verifications_path,
          {
            receipt: {
              data: "ABC",
              device_hash: "unknown-hash",
            },
          },
          user.token,
        )

        expect(response).to be_success
        json_response = JSON.parse(response.body)
        expect(json_response).to eq(expected_json)
      end
    end
  end

  context "validating the same receipt, with the same API key, with the same token" do
    it "is a success, twice" do
      user = create(:user)

      with_fake_apple_receipt do
        auth_post(
          api_v1_verifications_path,
          {
            receipt: {
              data: "ABC",
              device_hash: "unknown-hash",
            },
          },
          user.token,
        )

        expect(response).to be_success
      end

      auth_post(
        api_v1_verifications_path,
        {
          receipt: {
            data: "ABC",
            device_hash: "unknown-hash",
          },
        },
        user.token,
      )

      expect(response).to be_success
    end
  end

  context "valid receipt, known API key, known token for a matching receipt" do
    it "is a success" do
      user = create(:user)
      receipt = create(
        :receipt,
        user: user,
        device_hash: "known-hash",
        data: "ABC",
      )
      payload = {
        receipt: {
          data: receipt.data,
          device_hash: receipt.device_hash,
        },
      }

      auth_post api_v1_verifications_path, payload, user.token

      expect(response).to be_success
    end
  end

  context "valid receipt, known API key, known token for a different receipt" do
    it "is a failure" do
      receipt = create(:receipt, device_hash: "receipt A")
      other_receipt = create(:receipt, device_hash: "receipt B")
      user = receipt.user
      payload = {
        receipt: {
          data: receipt.data,
          device_hash: other_receipt.device_hash,
        },
      }

      auth_post api_v1_verifications_path, payload, user.token

      expect(response).to be_forbidden
    end
  end

  context "invalid receipt" do
    it "is a failure" do
      with_fake_apple_receipt(status: 21_003) do
        user = create(:user)
        payload = {
          receipt: { data: "" },
        }

        auth_post api_v1_verifications_path, payload, user.token

        expect(response).to be_forbidden
      end
    end
  end

  context "unknown API key" do
    it "is a failure" do
      with_fake_apple_receipt do
        auth_post api_v1_verifications_path, receipt: {}

        expect(response).to be_unauthorized
      end
    end
  end

  context "given an already validated sandbox receipt" do
    it "is a bad request when it is validated against production" do
      receipt = create(
        :receipt,
        environment: "sandbox",
        data: "ABC",
      )
      user = receipt.user
      payload = {
        receipt: {
          data: receipt.data,
          device_hash: receipt.device_hash,
        },
      }

      auth_post api_v1_verifications_path, payload, user.token

      expect(response).to be_bad_request
    end
  end

  it "respects sandbox" do
    with_fake_apple_receipt(url: "https://sandbox.example.com") do
      user = create(:user)

      auth_post(
        api_v1_verifications_path + "?sandbox=1",
        {
          receipt: {
            data: "ABC",
            device_hash: "unknown-hash",
          },
        },
        user.token,
      )

      expect(response).to be_success
    end
  end

  def auth_post(path, params, token = nil)
    credentials = authenticate_with_token(token || "less-sekkrit")
    post path, params, "HTTP_AUTHORIZATION" => credentials
  end
end
