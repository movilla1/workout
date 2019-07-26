require "rails_helper"
 
RSpec.feature "Users sign in" do
  before do
    @user = User.create(email: "test@example.com", password: "hello123")
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