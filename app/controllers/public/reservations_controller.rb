class Public::ReservationsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_beginning_of_week
  
  def index
    @non_business_day = 4
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
    @start_at = l(@start_at_obj, format: :time)
    @end_at = l(@end_at_obj, format: :time)
    
    @seat = Seat.find(params[:seat_id])
    @reservation_times = ReservationTime.all
    @display_time = ReservationTime.find_by(start_at: @start_at, end_at: @end_at)
    @reservations = Reservation.all.where("start_time >= ?", @display_date).where("start_time < ?", @display_date >> 1)
  end
  
  def new
    @reservation = Reservation.new(reservation_params)
  end
  
  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.customer_id = current_customer.id
    if @reservation.save
      redirect_to my_page_path(@reservation)
    else
      redirect_to reservations_path(seat_id: @reservation.seat_id, since_today: params[:since_today]), notice: '予約できませんでした。入力内容を確認してください。'
    end
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_update_params)
      redirect_to my_page_path(@reservation)
    else
      flash[:notice] = '変更できませんでした。入力内容を確認してください。'
      render :edit
    end
  end
  
  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
    redirect_to my_page_path(current_customer.id)
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:customer_id, :seat_id, :reservation_time_id, :start_time, :comment, :number_of_people)
  end
  
  def reservation_update_params
    params.require(:reservation).permit(:number_of_people, :comment)
  end
  
  def seat_id_get_params
    params.require(:reservation).permit(:seat_id)
  end
  
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
  
  
end
