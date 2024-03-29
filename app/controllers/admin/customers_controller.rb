class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page])
  end
  
  def show
    @customer = Customer.find(params[:id])
    @point = Point.where(customer_id: params[:id])
    @latest_point = @point.last
    @coupons = Coupon.where(customer_id: params[:id], is_active: true)
    @latest_coupon = @coupons.last
  end
  
  def edit
    @customer = Customer.find(params[:id])
  end
  
  def update
    customer = Customer.find(params[:id])
    if customer.update(customer_params)
      redirect_to admin_customer_path(customer.id)
    else
      @customer = customer
      render :edit
    end
  end
  
  def search
    if Customer.find_by(id: params[:id]).present?
      redirect_to admin_customer_path(params[:id])
    else
      @customers = Customer.page(params[:page])
      redirect_to admin_customers_path, notice: '検索したIDは見つかりませんでした。'
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :email, :is_active)
  end
  
end
