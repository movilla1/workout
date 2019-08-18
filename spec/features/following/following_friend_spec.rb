require 'rails_helper'

RSpec.feature 'Following friends' do
  before do
    @john = User.create!(
      first_name: 'john',
      last_name: 'doe',
      email: 'test_john@example.com',
      password: 'pass1234'
    )
    @fred = User.create!(
      first_name: 'fred',
      last_name: 'altman',
      email: 'test_fred@example.com',
      password: 'pass3215'
    )
    login_as(@john)
  end

  scenario "if signed in" do
    visit "/"

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@fred.full_name)

    href = "/friendships?friend_id=#{@john.id}"
    expect(page).not_to have_link("Follow", href: href)

    link = "a[href='/friendships?friend_id=#{@fred.id}']"
    find(link).click

    href2 = "/friendshipts?friend_id=#{@fred.id}"
    expect(page).not_to have_link("Follow", href: href2)
  end
end