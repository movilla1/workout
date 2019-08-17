require "rails_helper"
 
RSpec.feature "Users sign in" do
  before do
    @user = User.create(email: "test@example.com", password: "hello123", first_name: "John", last_name: "Doe")
  end

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign In"
    fill_in "Email",	with: "test@example.com"
    fill_in "Password",	with: "hello123"
    click_button "Log in"
    expect(page).to have_content("Signed in successfully")
    expect(page).to have_content("Signed in as #{@user.full_name}")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign In"
    fill_in "Email",	with: "test@example.com"
    fill_in "Password",	with: "hello132"
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password")
    expect(page).not_to have_content("Signed in as")
  end
end