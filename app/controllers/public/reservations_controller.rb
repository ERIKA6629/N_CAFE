class Public::ReservationsController < ApplicationController
  before_action :set_beginning_of_week
  
  def index
    @non_business_day = 4
    @before_non_buisiness_day = @non_business_day - 1
    
    @seat = Seat.find(params[:seat_id])
    @reservation_times = ReservationTime.all
    @display_time = ReservationTime.search_display_time
    @reservations = Reservation.all.where("start_time >= ?", Date.current).where("start_time < ?", Date.current >> 1)
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
      redirect_to reservations_path(seat_id: @reservation.seat_id), notice: '入力内容はすでに予約されています。'
    end
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    reservation = Reservation.find(params[:id])
    reservation.update!(reservation_update_params)
    redirect_to my_page_path(reservation)
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
