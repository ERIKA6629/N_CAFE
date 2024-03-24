class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @display_time = Time.current
    @display_date = @display_time.to_date
    current_minutes =  (I18n.l Time.current, format: :minutes).to_i
    if current_minutes >= 0 && current_minutes < 30
      @start_at_obj = @display_time.beginning_of_hour
      @end_at_obj = @display_time.beginning_of_hour.since(30.minutes)
    else
      @start_at_obj = @display_time.beginning_of_hour.since(30.minutes)
      @end_at_obj = @display_time.beginning_of_hour.since(60.minutes)
    end
    @open_time = Time.zone.parse("#{@display_time.to_date} #{'10:00'}")
    @close_time = Time.zone.parse("#{@display_time.to_date} #{'18:00'}")
    
    @customer = Customer.find(current_customer.id)
    @reservations = Reservation.where(customer_id: current_customer).where("start_time >= ?", @display_date)
    
    @point = Point.where(customer_id: current_customer.id)
    @coupon= Coupon.where(customer_id: current_customer.id, is_active: true)
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
