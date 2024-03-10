class Public::HomesController < ApplicationController
  
  def cafe_information
    
    @display_date = Time.current
    @seats = Seat.all
    if ReservationTime.search_display_time.nil?
      @reservation_time = ReservationTime.first
      @open_time = false
    else
      @reservation_time = ReservationTime.search_display_time
    end
    @reservations = Reservation.all
  end
  

end
