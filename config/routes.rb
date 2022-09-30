Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end
  end

  root to: 'users#index'

  get 'users/:user_id/posts_list', to: 'api#list_posts', as: :list_posts
  get 'users/:user_id/posts/:post_id/comments_list', to: 'api#list_comments', as: :list_comments
  post 'users/:user_id/posts/:post_id/comment_create', to: 'api#create_comment', as: :create_comment
end