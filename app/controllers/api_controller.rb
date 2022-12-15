class ApiController < ApplicationController
    protect_from_forgery with: :null_session
    skip_before_action :authenticate_user!
  
    include Response
  
    def list_posts
      authentication_token = params[:authentication_token]
      return unless check_token_user_params(authentication_token)
  
      posts = Post.where(author_id: params[:user_id])
      json_response(posts)
    end
  
    def create_comment
      authentication_token = params[:authentication_token]
      return unless check_token_user_params(authentication_token)
  
      post_id = params[:post_id]
      text = params[:text]
      return unless check_comment_params(text)
  
      comment = Comment.new(text:, author: @current_user, post_id:)
      if comment.save
        json_response(comment, 200)
      else
        json_response({ error: 'Comment creation failed, please try again later.' }, 500)
      end
    end
  
    def list_comments
      authentication_token = params[:authentication_token]
      return unless check_token_user_params(authentication_token)
  
      return unless check_post_params
  
      comments = Comment.where(post_id: params[:post_id], author_id: params[:user_id])
      json_response(comments)
    end
  
    private
  
    def check_comment_params(text)
      return false unless check_post_params
  
      if text.nil? || text.empty?
        json_response({ error: 'Comment text is empty.' }, 400)
        false
      else
        true
      end
    end
  
    def check_token_user_params(authentication_token)
      if authentication_token.nil?
        json_response({ error: 'Invalid token.' }, 400)
        false
      elsif !authenticate(authentication_token)
        json_response({ error: 'Not authorized.' }, 401)
        false
      elsif !User.exists?(params[:user_id])
        json_response({ error: 'User does not exist.' }, 404)
        false
      else
        true
      end
    end
  
    def authenticate(authentication_token)
      email = ApiHelper::JsonWebToken.decode(authentication_token)[0]
      user = User.find_by(email:)
      return false if user.nil?
  
      @current_user = user
      true
    end
  
    def check_post_params
      if Post.where(id: params[:post_id], author_id: params[:user_id]).exists?
        true
      else
        json_response({ error: 'Post does not exist.' }, 404)
        false
      end
    end
end
