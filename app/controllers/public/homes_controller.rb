class Public::HomesController < ApplicationController
  
  def cafe_information
    @non_business_day = 4
    @before_non_buisiness_day = @non_business_day - 1
    
    @display_date = Time.current
    @seats = Seat.all
    @reservation_time = ReservationTime.search_display_time
    @reservation_date = reservation_date_for_customer
    @reservations = Reservation.all
  end
  
  private
  
  def reservation_date_for_customer
    if @reservation_time.business_hours == "after_closing" && Date.today.wday == @before_non_buisiness_day
      return Time.current.ago(2.days)
    elsif @reservation_time.business_hours == "after_closing"
      return Time.current.tomorrow
    else
      return Time.current
    end
  end

end
