require "rails_helper"

describe "API authentification" do
  before do
    Rails.application.routes.draw do
      get "/api/v1/test" => "test#index"
    end
  end

  after do
    Rails.application.reload_routes!
  end

  context "when the user provides a valid api token" do
    it "allows the user to pass" do
      user = create(:user)
      credentials = authenticate_with_token(user.token)

      get "/api/v1/test", {}, "HTTP_AUTHORIZATION" => credentials

      expect(response).to be_a_success
      expect(response.body).to eq "Hello"
    end
  end

  context "when the user provides an invalid api token" do
    it "does not allow to user to pass" do
      create(:user, token: "sekkrit")
      credentials = authenticate_with_token("less-sekkrit")

      get "/api/v1/test", {}, "HTTP_AUTHORIZATION" => credentials

      expect(response).not_to be_a_success
      expect(response.status).to eq 401
    end
  end

  TestController = Class.new(Api::V1::BaseController) do
    def index
      render text: "Hello"
    end
  end
end
