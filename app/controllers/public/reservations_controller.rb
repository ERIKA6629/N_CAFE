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
  
  private
  
  def seat_id_get_params
    params.require(:reservation).permit(:seat_id)
  end
  
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
  
end
