class Admin::CouponsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customer = Customer.find(params[:customer_id])
    @coupons = @customer.coupons.order(created_at: :desc)
  end
    
  def update
    coupon = Coupon.find_by(customer_id: params[:id], is_active: true)
    coupon.is_active = false
    coupon.save!
    redirect_to admin_customer_coupons_path(coupon.customer_id)
  end
  
  private
    def customer_params
      params.require(:coupon).permit(:is_active)
    end
  
end
