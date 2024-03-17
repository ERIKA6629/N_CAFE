class Admin::PostsController < ApplicationController
  def new
    @new_post = Post.new
  end
  
  def create
    new_post = Post.new(post_params)
    new_post.save
    redirect_to admin_posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
  
end
