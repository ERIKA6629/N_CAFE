class Public::MenusController < ApplicationController
  
  def index
    @genres = Genre.order(name: :asc)
  end
  
  def show
    @menu = Menu.find(params[:id])
  end
end
