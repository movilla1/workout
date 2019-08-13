require "rails_helper"

RSpec.feature "Creating exercise" do
  before do
    @john = User.create(email: "john@here.com", password: "test1234")
    login_as(@john)
  end

  scenario "Create a new excercise" do
    visit "/"
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")

    fill_in "Duration",	with: "30"
    fill_in "Workout Details",	with: "Weight Lifting"
    fill_in "Activity Date",	with: 3.days.ago
    click_button "Save Exercise"
    expect(page).to have_content("Exercise has been created")
    exercise = Exercise.last
    expect(current_path).to eq(user_exercise_path(@john, exercise))
    expect(exercise.user_id).to eq(@john.id)
  end

  scenario "Failed to createnew exercise" do
    visit "/"
    click_link "My Lounge"
    click_link "New Workout"
    expect(page).to have_link("Back")

    fill_in "Duration",	with: ""
    fill_in "Workout Details",	with: "Weight Lifting"
    fill_in "Activity Date",	with: 3.days.ago
    click_button "Save Exercise"
    expect(page).to have_content("Exercise has failed to save")
    expect(current_path).to eq(user_exercises_path(user_id: @john.id))
  end
end
