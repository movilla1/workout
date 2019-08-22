require "rails_helper"

RSpec.feature "Listing exercises" do
  before do
    @john = User.create(email: "john@here.com", password: "test1234", first_name: "John", last_name: "Doe")
    @sara = User.create(email: "sara@here.com", password: "test1234", first_name: "Sara", last_name: "Doenty")
    @following = Friendship.create(user_id: @john.id, friend_id: @sara.id)
    login_as(@john)

    @ex1 = @john.exercises.create(duration_in_minutes: "10", workout: "This is it", workout_date: 3.days.ago)
    @ex2 = @john.exercises.create(duration_in_minutes: "5", workout: "That is not", workout_date: 2.days.ago)
    @ex3 = @john.exercises.create(duration_in_minutes: "12", workout: "laying down", workout_date: 9.days.ago)
  end

  scenario "Shows User's workout for the last 7 days" do
    visit "/"
    click_link "My Lounge"
    expect(page).to have_content(@ex1.workout)
    expect(page).to have_content(@ex1.workout_date)
    expect(page).to have_content(@ex1.workout)
    expect(page).to have_content(@ex2.workout_date)
  end

  scenario "Latest 7 days only show" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content(@ex1.duration_in_minutes)
    expect(page).to have_content(@ex1.workout)
    expect(page).to have_content(@ex2.workout_date)
    expect(page).not_to have_content(@ex3.workout)
  end

  scenario "No workouts created" do
    @ex1.destroy
    @ex2.destroy
    visit "/"
    click_link "My Lounge"
    expect(page).to have_content("No workout data found")
  end

  scenario "Shows the list of friends" do
    visit "/"
    click_link "My Lounge"

    expect(page).to have_content("My Friends")
    expect(page).to have_link(@sara.full_name)
    expect(page).to have_link("Unfollow")
  end
end
