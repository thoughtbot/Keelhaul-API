require "rails_helper"

feature "Admin user" do
  scenario "visits admin dashboard" do
    visit admin_root_path(as: create(:user, :admin))
    expect(page).to have_text("Receipts")
  end
end
