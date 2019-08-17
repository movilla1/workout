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
    [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15].each do |num|
      User.create!( first_name: "Joe#{num}", last_name: "figgy#{num}", email: "jfiggy#{num}@here.com", password: "here1234")
    end
  end

  scenario "Listing all members on dashboard" do
    visit "/"

    expect(page).to have_content("List of Members")
    expect(page).to have_content(@john.first_name)
    expect(page).to have_content(@fred.last_name)
    expect(page).not_to have_content("Joe15")
    expect(page).to have_content("Next")
  end
end
