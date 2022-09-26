require 'rails_helper'

RSpec.feature "UserShow.spec.rbs", type: :feature do
  before :each do
    @user = User.create(name: 'Jake', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Algeria.', post_counter: 0)
    @user2 = User.create(name: 'Joel', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Student at microverse.', post_counter: 0)
    @post = Post.create(author: @user, title: 'Post 1', text: 'This is my new post', likes_counter: 0, comments_counter: 0)
    Comment.create(post: @post, author: @user2, text: 'Hi Lilly!')
    Comment.create(post: @post, author: @user2, text: 'Hi Lilly!')

    visit user_post_path(@post.author, @post)
  end
  it "I can see the post's title" do
    expect(page).to have_content(@post.title)
  end
  it 'I can see who wrote the post' do
    expect(page).to have_content(@user.name)
  end
  it 'I can see how many comments it has' do
    expect(page).to have_content('Comments: 2')
  end
  it 'I can see how many likes it has' do
    expect(page).to have_content('Likes: 0')
  end
  it 'I can see the post body' do
    expect(page).to have_content(@post.text)
  end
  it 'I can see the username of each commentor' do
    expect(page).to have_content(@user2.name)
  end
  it 'I can see the comment each commentor left' do
    expect(page).to have_content('Hi Lilly!')
  end
end
