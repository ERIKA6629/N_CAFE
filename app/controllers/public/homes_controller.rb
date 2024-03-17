class Public::HomesController < ApplicationController
  
  def cafe_information
    @non_business_day = 4
    @display_time = Time.current
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
    @open_time = Time.zone.parse("#{@display_time.to_date} #{'10:00'}")
    @close_time = Time.zone.parse("#{@display_time.to_date} #{'18:00'}")
    @seats = Seat.all
    @reservation_time = ReservationTime.find_by(start_at: @start_at, end_at: @end_at)
    @reservations = Reservation.all
  end
  
  private

end
