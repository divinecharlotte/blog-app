require 'rails_helper'

RSpec.feature 'Post Index Page', type: :feature do
  before :each do
    @user = User.create(name: 'Lilly', photo: 'https://images.unsplash.com/photo87&q=80', bio: 'Teacher from Poland.',
                        post_counter: 0)
    @user2 = User.create(name: 'Tom', photo: 'https://images.uw=687&q=80', bio: 'Teacher from Poland.', post_counter: 0)
    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                              likes_counter: 0)
    5.times do |_i|
      Comment.create(post: @first_post, author: @user2, text: 'Hi Lilly!')
    end
    visit user_posts_path(@user)
  end
  it 'displays user profile picture' do
    expect(page).to have_css("img[src*='#{@user.photo}']")
  end

  it "displays the user's username " do
    expect(page).to have_content(@user.name)
  end

  it 'displays number of posts user has written' do
    expect(page).to have_content('Number of posts: 1')
  end

  it 'displays the post title' do
    expect(page).to have_content(@first_post.title)
  end

  it 'displays the post body' do
    expect(page).to have_content(@first_post.text)
  end

  it 'display the first comment on a post' do
    expect(page).to have_content('Hi Lilly!')
  end

  it 'display how many comments a post has' do
    expect(page).to have_content("Comments: #{@first_post.comments_counter}")
  end

  it 'display the how many Likes  a post has' do
    expect(page).to have_content("Likes: #{@first_post.likes_counter}")
  end

  it "" do
    
  end
  it 'after clicking on a post, redirect on a post show page' do
    click_link(@first_post.title)
    expect(page).to have_content("Comments: #{@first_post.comments_counter} ")
  end
end
