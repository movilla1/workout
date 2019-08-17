require "rails_helper"
RSpec.feature "Listing exercises" do
  before do
    @john = User.create(email: "john@here.com", password: "test1234", first_name: "John", last_name: "Doe")
    login_as(@john)

    @ex1 = @john.exercises.create(duration_in_minutes: "33", workout: "This is it", workout_date: 3.days.ago)
    @ex2 = @john.exercises.create(duration_in_minutes: "55", workout: "That is not", workout_date: 2.days.ago)
  end

  scenario "Editing own record" do
    visit "/"
    click_link "My Lounge"
    path = "/users/#{@john.id}/exercises/#{@ex1.id}/edit"
    link = "a[href=\'#{path}\']"
    find(link).click

    fill_in "Duration", with: 44
    click_button "Save Exercise"

    expect(page).to have_content("Exercise Updated Successfully")
    expect(page).not_to have_content("33")
    expect(page).to have_content("44")
  end
end
