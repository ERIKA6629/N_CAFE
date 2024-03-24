class Admin::MenusController < ApplicationController
  
  def index
    @menus = Menu.all
  end
  
  def show
  end
  
  def new
    @menu = Menu.new
  end
  
  def create
    menu = Menu.new(menu_params)
    menu.save
    redirect_to admin_menus_path
  end
  
  private
  
  def menu_params
    params.require(:menu).permit(:image, :genre_id, :name, :introduction, :price)
  end
end
