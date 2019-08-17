require "rails_helper"
 
RSpec.feature "Users signup" do
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign Up"
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email",	with: "test@example.com"
    fill_in "Password",	with: "hello123"
    fill_in "Password confirmation",	with: "hello123"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully")
    expect(page).to have_content("John Doe")
  end

  scenario "with invalid credentials" do
    visit "/"
    click_link "Sign Up"
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Doe"
    fill_in "Email",	with: "test@example.com"
    fill_in "Password",	with: ""
    fill_in "Password confirmation",	with: ""
    click_button "Sign up"
    expect(page).to have_content("prohibited this user from being saved")
  end
end
