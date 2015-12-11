require "rails_helper"

feature "A user signs up" do
  scenario "via visiting the homepage" do
    visit root_url

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "abc123"
    click_on "Sign up"

    expect(page).to have_content("Welcome, user@example.com")
    expect(page).to have_content(/API token: /)
  end

  scenario "gets redirected if already signed in" do
    user = create(:user)
    sign_in(user)

    visit root_path

    expect(page).to have_content("Welcome, user@example.com")
  end

  def sign_in(user)
    visit sign_in_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end
