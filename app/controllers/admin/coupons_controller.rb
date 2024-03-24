class Admin::CouponsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @customer = Customer.find(params[:id])
    @coupons = Coupon.where(customer_id: params[:id]).order('created_at DESC')
  end
    
  def update
    coupon = Coupon.find_by(customer_id: params[:id], is_active: true)
    coupon.is_active = false
    coupon.save!
    redirect_to admin_coupon_path(coupon.customer_id)
  end
  
  private
    def customer_params
      params.require(:coupon).permit(:is_active)
    end
  
end
