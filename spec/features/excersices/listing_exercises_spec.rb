require "rails_helper"

RSpec.feature "Listing exercises" do
  before do
    @john = User.create(email: "john@here.com", password: "test1234")
    login_as(@john)

    @ex1 = @john.exercises.create()
    @ex2 = @john.exercises.create()
  end
  scenario "Shows User's workout for the last 7 days" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content(@ex1.duration_in_minutes)
    expect(page).to have_content(@ex1.workout)
    expect(page).to have_content(@ex2.workout_date)
  end

  scenario "No workouts created" do
    @ex1.destroy
    @ex2.destroy
    visit "/"
    click_link "My Lounge"
    expect(page).to have_content("No workout data found")
  end
end
