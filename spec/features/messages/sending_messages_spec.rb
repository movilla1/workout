require "rails_helper"

RSpec.feature "Show friend workout" do
  before do
    @john = User.create(email: "john@here.com", password: "test1234", first_name: "John", last_name: "Doe")
    @sara = User.create(email: "sara@here.com", password: "test1234", first_name: "Sara", last_name: "Doenty")
    @henry = User.create(email: "henry@here.com", password: "test1234", first_name: "Henry", last_name: "Hellfish")
    @following = Friendship.create(user_id: @john.id, friend_id: @sara.id)
    @room_name = @john.full_name.tr(" ","-")
    @room = Room.create(name: @room_name, user_id: @john.id)
    login_as(@john)

    Friendship.create(user_id: @sara.id, friend_id: @john.id)
    Friendship.create(user_id: @henry.id, friend_id: @john.id)
  end

  scenario "Followers show in chatroom" do
    visit "/"
    click_link "My Lounge"
    expect(page).to have_content(@room_name)
    fill_in "message-field", with: "Hello"
    click_button "Post"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(@sara.full_name)
      expect(page).to have_link(@henry.full_name)
    end
  end
end
