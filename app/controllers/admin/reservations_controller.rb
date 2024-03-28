class Admin::ReservationsController < ApplicationController
  before_action :authenticate_admin!
  
  def new
    @reservation = Reservation.new(reservation_params)
  end
  
  def create
    @customer = Customer.admin
    @reservation = @customer.reservations.build(reservation_params)
    if @reservation.save
      redirect_to admin_reservation_path(@reservation)
    else
      redirect_to admin_path(display_date: @reservation.start_time), notice: '入力内容はすでに予約されています。'
    end
  end
  
  def create_all
    @reservation = Reservation.new(reservation_params)
    @customer = Customer.admin
    
    @reservation_times = ReservationTime.all
    
    if check_existence_of_reservation(@reservation.seat_id,@reservation.start_time)
      @reservation_times.each do |reservation_time|
        @reservation = @customer.reservations.build(reservation_params)
        @reservation.reservation_time = reservation_time
        @reservation.number_of_people = @reservation.seat.limit_number
        @reservation.comment = "一括予約"
        @reservation.save
      end
      redirect_to admin_path(display_date: @reservation.start_time)
    else
      redirect_to admin_path(display_date: @reservation.start_time), notice: '入力内容はすでに予約されています。'
    end
  end
  
  def index
    if params[:display_date].present?
      @display_date = Time.zone.parse("#{params[:display_date]} 00:00:00").to_date
    else
      @display_date = Time.current.to_date
    end
    @non_business_day = 4
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
  
  def check_existence_of_reservation(seat_id,start_time)
    return true if Reservation.where(seat_id: seat_id, start_time: start_time).empty?
  end
  
end
