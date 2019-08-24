require "rails_helper"

RSpec.feature "Show friend workout" do
  before do
    @john = User.create(email: "john@here.com", password: "test1234", first_name: "John", last_name: "Doe")
    @sara = User.create(email: "sara@here.com", password: "test1234", first_name: "Sara", last_name: "Doenty")
    @following = Friendship.create(user_id: @john.id, friend_id: @sara.id)
    login_as(@john)

    @ex1 = @sara.exercises.create(duration_in_minutes: "10", workout: "This is it", workout_date: 3.days.ago)
    @ex2 = @sara.exercises.create(duration_in_minutes: "5", workout: "That is not", workout_date: 2.days.ago)
    @ex3 = @sara.exercises.create(duration_in_minutes: "12", workout: "laying down", workout_date: 1.day.ago)
    @ex4 = @sara.exercises.create(duration_in_minutes: "10", workout: "walking like a penguin", workout_date: 2.days.ago)
    @ex5 = @sara.exercises.create(duration_in_minutes: "9", workout: "scream as a penguin", workout_date: 9.days.ago)
  end

  scenario "Show friend workouts in the past 7 days" do
    visit "/"
    click_link "My Lounge"
    click_link @sara.full_name

    expect(page).to have_content(@sara.full_name + "'s Exercises")
    expect(page).to have_content(@ex4.workout)
    expect(page).to have_css("div#chart")
    expect(page).not_to have_content(@ex5.workout_date)
  end
end
