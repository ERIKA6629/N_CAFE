class Admin::MenusController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @genres = Genre.all
  end
  
  def show
    @menu = Menu.find(params[:id])
  end
  
  def new
    @menu = Menu.new
  end
  
  def create
    @menu = Menu.new(menu_params)
    if @menu.save
      redirect_to admin_menu_path(@menu.id)
    else
      render :new
    end
  end
  
  def edit
    @menu = Menu.find(params[:id])
  end
  
  def update
    @menu = Menu.find(params[:id])
    if @menu.update(menu_params)
      sleep(3) #S3への画像反映のタイムラグを考慮して3秒待機
      redirect_to admin_menu_path(@menu.id)
    else
      render :edit
    end
  end
  
  def destroy
    menu = Menu.find(params[:id])
    menu.destroy
    redirect_to admin_menus_path
  end
  
  private
  
  def menu_params
    params.require(:menu).permit(:image, :genre_id, :name, :introduction, :price)
  end
end
