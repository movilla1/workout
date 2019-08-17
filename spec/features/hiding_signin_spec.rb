require "rails_helper"

RSpec.feature "Hide sign in link" do
  before do
    @user = User.create(email: "test@example.com", password: "hello123", first_name: "John", last_name: "Doe")
    login_as(@user)
  end

  scenario "should not have signin link" do
    visit "/"
    expect(page).not_to have_link("Sign In")
  end

  scenario "Should not have signup link" do
    visit "/"
    expect(page).not_to have_link("Sign Up")
  end
end