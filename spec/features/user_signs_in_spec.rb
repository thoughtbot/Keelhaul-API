require "rails_helper"

feature "A user signs in" do
  scenario "via visiting the homepage" do
    create(
      :user,
      email: "user@example.com",
      password: "abc123",
    )
    visit root_url

    click_link "Sign in"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "abc123"
    click_button "Sign in"

    expect(page).to have_content("Welcome, user@example.com")
  end
end
