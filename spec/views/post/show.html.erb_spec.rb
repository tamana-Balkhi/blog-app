require 'rails_helper'

RSpec.describe 'User post show page', type: :feature do
  let!(:user) do
    User.create(
      name: 'Victor',
      photo: 'https://www.bing.com/th?id=ODL.c83b34c2350e6cd3a1010f7d1998cfa8&w=143&h=198&c=12&rs=1&qlt=99&pcl=faf9f7&o=6&pid=13.1',
      bio: 'author'
    )
  end

  let!(:post) do
    Post.create(
      author_id: user.id,
      title: 'post1',
      text: 'this is my first post'
    )
  end

  let!(:comment) do
    Comment.create(
      post_id: post.id,
      author_id: user.id,
      text: 'This is my first comment'
    )
  end

  let!(:like) do
    Like.create(
      post_id: post.id,
      author_id: user.id
    )
  end

  before(:each) do
    visit user_post_path(user, post)
  end

  it "I can see the post's title." do
    expect(page).to have_content(post.title)
  end

  it 'I can see who wrote the post.' do
    expect(page).to have_content(user.name)
  end

  it 'I can see how many comments it has.' do
    expect(page).to have_content('Comments:1')
  end

  it 'I can see how many likes it has.' do
    expect(page).to have_content('Likes:1')
  end

  it 'I can see the post body.' do
    expect(page).to have_content(post.text)
  end

  it 'I can see the username of each commentor.' do
    expect(page).to have_content("#{user.name} :")
  end

  it 'I can see the comment each commentor left.' do
    expect(page).to have_content(comment.text)
  end
end
