require 'rails_helper'
RSpec.feature 'User Index Page', type: :feature do
  before :each do
    @user = User.create(name: 'Lilly',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80', bio: 'Teacher from Poland.', post_counter: 0)
    @first_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                              likes_counter: 0)
    @second_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                               likes_counter: 0)
    @third_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                              likes_counter: 0)
    @fourth_post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                               likes_counter: 0)
    5.times do |_i|
      Comment.create(post: @first_post, author: @user, text: 'Hi Lilly!')
    end

    visit user_path(@user.id)
  end

  it "should  show user's profile picture" do
    expect(page).to have_selector('img')
  end

  it "should show the user's username." do
    expect(page).to have_content('Lilly')
  end

  it 'should show the number of posts the user has written.' do
    expect(page).to have_content('Number of posts: 4')
  end

  it "it should show user's bio" do
    expect(page).to have_content('Bio')
  end

  it "should show user's first 3 posts." do
    expect(page).to have_content('Hello')
    expect(page).to have_content('Hello')
    expect(page).to have_content('Hello')
  end

  it "it should show  a button that lets me view all of a user's posts." do
    expect(page).to have_content 'See All Posts'
  end

  it " When I click a user's post, it redirects me to that post's show page." do
    visit(user_posts_path(@user.id))
    expect(page).to have_current_path user_posts_path(@user.id)
  end

  it "When I click to see all posts, it redirects me to the user's post's index page." do
    click_link 'See All Posts'
    expect(page).to have_current_path user_posts_path(@user)
  end
end
