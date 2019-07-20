require "rails_helper"

RSpec.feature "Home page" do
  scenario "Visit home page" do
    visit "/"
    expect(page).to have_link("Athletes Den!")
    expect(page).to have_link("Home")
    expect(page).to have_content("Workout lounge")
    expect(page).to have_content("Show off your workout")
  end
end
