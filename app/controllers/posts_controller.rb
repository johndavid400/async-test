class PostsController < ApplicationController

  def index
    @posts = get_posts
  end

  private

  def get_posts
    return Post.search(params[:search]) if params[:search].present?

    Post.all
  end
end
