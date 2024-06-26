class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end
  
  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      render :index
    end
  end
  
  def edit
    @genre = Genre.find(params[:id])
  end
  
  def update
    genre = Genre.find(params[:id])
    if genre.update(genre_params)
      sleep(3) #S3への画像反映のタイムラグを考慮して3秒待機
      redirect_to admin_genres_path
    else
      @genre = genre
      render :edit
    end
  end
  
  def destroy
    @genre = Genre.find(params[:id])
    if !@genre.menus.any?
      @genre.destroy
      redirect_to admin_genres_path
    else
      @genres = Genre.all
      @genre = Genre.new
      flash[:notice] = 'ジャンルを削除できませんでした。'
      render :index
    end
  end
  
  private
  
  def genre_params
    params.require(:genre).permit(:name, :image)
  end
end
