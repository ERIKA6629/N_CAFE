class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
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
    @index_posts = Post.order('created_at DESC').page(params[:page])
  end
  
  def show
    @show_post = Post.find(params[:id])
  end
  
  def edit
    @edit_post = Post.find(params[:id])
  end
  
  def update
    edit_post = Post.find(params[:id])
    if edit_post.update(edit_post_params)
      redirect_to admin_post_path(edit_post.id)
    else
      @edit_post = edit_post
      render :edit
    end
  end
  
  def destroy
    destroy_post = Post.find(params[:id])
    destroy_post.destroy
    redirect_to admin_posts_path
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end
  
  def edit_post_params
    params.require(:post).permit(:title, :content, :image)
  end
  
end
