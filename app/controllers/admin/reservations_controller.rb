class Admin::ReservationsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @reservation = Reservation.new(reservation_params)
    @reservation.start_time = Date.today
  end
  
  def create
    reservation = Reservation.new(reservation_params)
    reservation.customer_id = 1
    reservation.save!
    redirect_to admin_path
  end
  
  def search
    @reservations = Reservation.where(start_time: reservation_time_get_params[:start_time])
    @reservation_times = ReservationTime.all
    @seats = Seat.all
    redirect_to admin_path
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:customer_id, :seat_id, :reservation_time_id, :start_time, :comment, :number_of_people)
  end
  
  def reservation_time_get_params
    params.require(:reservation).permit(:start_time)
  end
end
