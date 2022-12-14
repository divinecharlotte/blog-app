require 'rails_helper'

RSpec.feature 'Test Post show', type: :feature do
  before :each do
    @user = User.create(name: 'Lilly',
                        photo: 'https://unsplash.com/photos/l-T-LpQnNRg', bio: 'Teacher from Poland.', post_counter: 0)

    @post = Post.create(author: @user, title: 'Post 1', text: 'This is my new post', comments_counter: 0,
                        likes_counter: 0)
    Comment.create(post: @post, author: @user, text: 'Hi Lilly!')
    Comment.create(post: @post, author: @user, text: 'Hi Lilly!')

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
    expect(page).to have_content(@user.name)
  end
  it 'I can see the comment each commentor left' do
    expect(page).to have_content('Hi Lilly!')
  end
end
