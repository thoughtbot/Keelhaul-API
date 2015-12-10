require "rails_helper"

describe User do
  context "generating tokens" do
    it "generates a token for created users" do
      user = build(:user)

      expect { user.save }.to change { user.token }.from(nil)
      expect(user.token).to be_present
    end

    it "does not override the token on save" do
      user = create(:user)

      expect(user.token).to be_present
      expect { user.save }.not_to change { user.token }
    end
  end
end
