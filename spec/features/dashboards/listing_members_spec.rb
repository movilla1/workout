require "rails_helper"

RSpec.feature "List members on home page" do
  before do
    @john = User.create!(
      first_name: "john",
      last_name: "doe",
      email: "test_john@example.com",
      password: "pass1234")
    @fred = User.create!(
      first_name: "fred",
      last_name: "altman",
      email: "test_fred@example.com",
      password: "pass3215")
  end

  scenario "Listing all members on dashboard" do
    visit "/"

    expect(page).to have_content("List of Members")
    expect(page).to have_content(@john.first_name)
    expect(page).to have_content(@fred.last_name)
  end
end
