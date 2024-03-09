class Admin::ReservationsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @reservation = Reservation.new(reservation_params)
  end
  
  def create
    reservation = Reservation.new(reservation_params)
    reservation.customer_id = 1
    reservation.save!
    redirect_to admin_reservation_path(reservation.id)
  end
  
  def index
    @display_date = Date.today
    @reservation_times = ReservationTime.all
    @seats = Seat.all
    @reservations = Reservation.where(start_time: @display_date).all
  end
  
  def search
    @display_date = reservation_time_get_params[:start_time].to_date
    @reservations = Reservation.all
    @reservation_times = ReservationTime.all
    @seats = Seat.all
    render :index
  end
  
  def show
    @reservation = Reservation.find(params[:id])
  end
  
  def edit
    @reservation = Reservation.find(params[:id])
  end
  
  def update
    reservation = Reservation.find(params[:id])
    reservation.update!(reservation_params)
    redirect_to admin_reservation_path(reservation.id)
  end
  
  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
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
