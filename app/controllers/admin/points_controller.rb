class Admin::PointsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    @point = Point.new(customer_params)
    if @point.save
      redirect_to admin_customer_path(@point.customer_id)
    else
      redirect_to admin_customer_path(@point.customer_id)
    end
  end
  
  private
  
  def customer_params
    params.require(:point).permit(:customer_id, :amount)
  end
end
