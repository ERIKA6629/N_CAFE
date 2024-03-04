class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @customers = Customer.page(params[:page])
  end
  
  def show
    @customer = Customer.find(params[:id])
  end
  
  def search
    if Customer.find_by(id: params[:id]).present?
      redirect_to admin_customer_path(params[:id])
    else
      @customers = Customer.page(params[:page])
      redirect_to admin_customers_path, notice: '検索したIDは見つかりませんでした。'
    end
  end
  
end
