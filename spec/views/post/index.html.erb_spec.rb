require 'rails_helper'

RSpec.describe 'User post index page', type: :feature do
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

  let!(:post1) do
    Post.create(
      author_id: user1.id,
      title: 'post1',
      text: 'this is my first post'
    )
  end

  let!(:post2) do
    Post.create(
      author_id: user1.id,
      title: 'post2',
      text: 'this is my second post'
    )
  end

  let!(:post3) do
    Post.create(
      author_id: user1.id,
      title: 'post3',
      text: 'this is my third post'
    )
  end

  let!(:post4) do
    Post.create(
      author_id: user1.id,
      title: 'post4',
      text: 'this is my fourth post'
    )
  end

  let!(:comment) do
    Comment.create(
      post_id: post3.id,
      author_id: user1.id,
      text: 'This is my third comment'
    )
  end

  let!(:like) do
    Like.create(
      post_id: post3.id,
      author_id: user1.id
    )
  end

  before(:each) do
    visit user_posts_path(user1)
  end

  it 'I can see the users profile picture.' do
    expect(page).to have_xpath("//img[@src='#{user1.photo}']")
  end

  it 'I can see the users username.' do
    expect(page).to have_content('Victor')
  end

  it 'I can see the number of posts the user has written.' do
    expect(page).to have_content(/posts:4/i)
  end

  it 'I can see a posts title.' do
    expect(page).to have_content('Post #', count: 4)
  end

  it 'I can see some of the posts body.' do
    expect(page).to have_content(post1.text, count: 4)
  end

  it 'I can see the first comments on a post.' do
    expect(page).to have_content(comment.text)
  end

  it 'I can see how many comments a post has.' do
    expect(page).to have_content('Comments:1')
  end

  it 'I can see how many likes a post has.' do
    expect(page).to have_content('Likes:1')
  end

  it 'I can see a section for pagination if there are more posts than fit on the view.' do
    expect(page).to have_button('Paginations')
  end

  it 'When I click on a post, it redirects me to that posts show page.' do
    click_link("Post ##{post2.id}")
    expect(page).to have_content("Post ##{post2.id} by #{user1.name}")
  end
end
