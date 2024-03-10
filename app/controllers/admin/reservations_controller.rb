class Admin::ReservationsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @reservation = Reservation.new(reservation_params)
  end
  
  def create
    @customer = Customer.admin
    @reservation = @customer.reservations.build(reservation_params)
    @reservation.save!
    redirect_to admin_reservation_path(@reservation)
  end
  
  def index
    if params[:display_date].present?
      @display_date = Time.zone.parse("#{params[:display_date]} 00:00:00").to_date
    else
      @display_date = Time.current.to_date
    end
    @reservation_times = ReservationTime.all
    @seats = Seat.all
    @reservations = Reservation.all
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
  
end
