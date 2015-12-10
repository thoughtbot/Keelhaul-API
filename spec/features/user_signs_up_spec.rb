require "rails_helper"

feature "A user signs up" do
  scenario "via visiting the homepage" do
    visit root_url

    click_link "Sign up"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "abc123"
    click_on "Sign up"

    expect(page).to have_content("Welcome, user@example.com")
    expect(page).to have_content(/API token: /)
  end
end
