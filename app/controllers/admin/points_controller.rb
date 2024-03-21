class Admin::PointsController < ApplicationController
  def create
    @point = Point.new(customer_params)
    @point.save
    @points = Point.where(customer_id: @point.customer_id)
    if @points.count >= 10
      Coupon.create_coupon(@point.customer_id)
      @points.destroy_all
    end
      redirect_to admin_customer_path(@point.customer_id)
  end
  
  private
  
  def customer_params
    params.require(:point).permit(:customer_id, :amount)
  end
end
