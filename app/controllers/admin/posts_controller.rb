class Admin::PostsController < ApplicationController
  def new
    @new_post = Post.new
  end
  
  def create
    @new_post = Post.new(post_params)
    if @new_post.save
      redirect_to admin_posts_path
    else
      @new_post　= @new_post
      render :new
    end
  end
  
  def index
    @index_posts = Post.order('created_at DESC')
  end
  
  def show
    @show_post = Post.find(params[:id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
  
end
