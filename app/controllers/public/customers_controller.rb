class Public::CustomersController < ApplicationController
  
  before_action :ensure_guest_user, only: [:edit]

  def show
    @customer = Customer.find(current_customer.id)
  end
  
  def edit
    @customer = Customer.find(current_customer.id)
  end
  
  def update
    customer = Customer.find(current_customer.id)
    if customer.update(customer_params)
      redirect_to my_page_path(customer.id)
    else
      @customer = customer
      render :edit
    end
  end
  
  def withdraw
    customer = Customer.find(current_customer.id)
    customer.update(is_active: false)
    reset_session
    redirect_to new_customer_registration_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :telephone_number, :email)
  end
  
  def ensure_guest_user
    @customer = Customer.find(current_customer.id)
    if @customer.guest_user?
      redirect_to public_top_path , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
end
