class Public::HomesController < ApplicationController
  
  def cafe_information
    
    @display_date = Time.current
    @reservation_date = Time.current
    @seats = Seat.all
    @reservation_time = ReservationTime.search_display_time
    if @reservation_time.business_hours == "after_closing" && Date.today.wday == 3
      @reservation_date = Time.current.ago(2.days)
    elsif @reservation_time.business_hours == "after_closing"
      @reservation_date = Time.current.tomorrow
    end
    @reservations = Reservation.all
  end
  

end
