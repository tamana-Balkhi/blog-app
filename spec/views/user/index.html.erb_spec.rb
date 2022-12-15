require 'rails_helper'

RSpec.describe 'User pages functionality: User index page ', type: :feature do
  let!(:user1) do
    User.create(
      name: 'Victor',
      photo: 'https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1',
      bio: 'author'
    )
  end

  let!(:user2) do
    User.create(
      name: 'shahin',
      photo: 'https://th.bing.com/th?q=Shahin+Artist&w=120&h=120&c=1&rs=1&qlt=90&cb=1&pid=InlineBlock&mkt=en-WW&cc=AF&setlang=en&adlt=strict&t=1&mw=247',
      bio: 'artist'
    )
  end

  it 'signs @user /users/ in home' do
    visit '/users'
    expect(current_path).to eq(users_path)
  end

  it 'I can see the username of all other users.' do
    visit root_path
    expect(page).to have_text(user1.name)
    expect(page).to have_text(user2.name)
  end

  it 'I can see the number of posts each user has written.' do
    visit users_path
    expect(page).to have_text(/posts: #{user1.postCounter}/i)
  end

  it 'I can see the profile picture for each user' do
    visit users_path
    expect(page).to have_xpath("//img[@src ='#{user1.photo}']")
  end

  it "When I click on a user, I am redirected to that user's show page' " do
    visit users_path
    click_on user1.name
    expect(page).to have_current_path(user_path(user1))
  end
end
