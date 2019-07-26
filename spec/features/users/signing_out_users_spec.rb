require "rails_helper"

RSpec.feature "Users signout" do
  before do
    @user = User.create(email: "test@example.com", password: "hello123")
    login_as(@user)
  end

  scenario "Signout user" do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content("Signed out successfully")
    expect(page).not_to have_content("Signed in as")
    expect(page).not_to have_link("Sign out")
  end
end