require "rails_helper"
RSpec.feature "Deleting exercise" do
  before do
    @john = User.create(email: "john@here.com", password: "test1234", first_name: "John", last_name: "Doe")
    login_as(@john)

    @ex1 = @john.exercises.create(duration_in_minutes: "33", workout: "This is it", workout_date: 3.days.ago)
    @ex2 = @john.exercises.create(duration_in_minutes: "55", workout: "That is not", workout_date: 2.days.ago)
  end

  scenario "Delete one record" do
    visit "/"
    click_link "My Lounge"
    path = "/users/#{@john.id}/exercises/#{@ex1.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Delete']"
    find(:xpath, link).click

    expect(page).to have_content("Exercise Deleted Successfully")
    expect(page).not_to have_content("33")
    expect(page).to have_content("55")
    expect(Exercise.all.count).to eq(1)
  end
end
