require 'rails_helper'

RSpec.describe Post, type: :model do
  user = User.create(
    name: 'Doe', photo: 'https://doe.com/me.png',
    bio: 'Iam John Doe.', post_counter: 0
  )

  post = Post.create(
    title: 'About', text: 'About me', comments_counter: 1,
    likes_counter: 0, author_id: user.id
  )

  8.times.collect do
    Comment.create(post:, author: user, text: 'first comment')
  end

  context 'recent_five_comments' do
    it 'return at most 5 comments' do
      expect(post.recent_five_comments.length).to be_between(0, 5).inclusive
    end

    it 'should return 5 comments' do
      expect(post.recent_five_comments.length).to eql(5)
    end
  end

  context 'update_posts_counter' do
    post.update_posts_counter
    it ' incriment posts_counter' do
      expect(User.find(user.id).post_counter) == (user.post_counter + 1)
    end
  end
end
