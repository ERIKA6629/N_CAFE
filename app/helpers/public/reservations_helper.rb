module Public::ReservationsHelper
  
  def for_showing_reservations(start_at_obj, day, start_at)
    reservation_time_obj = Time.zone.parse("#{day.to_s} #{start_at.to_s}")
    
    return true if start_at_obj > reservation_time_obj || reservation_time_obj > Time.current.since(1.month)
    
  end
  
  def now_seat_result(seat, start_at, end_at)
    seat.reservations.where(start_time: Time.current.to_date)
    .map { |o| r =  o.reservation_time; r.start_at == start_at && r.end_at == end_at }.include?(true) ? "x" : "o"
  end
  
  def tomorrow_seat_result(seat)
    seat.reservations.where(start_time: Time.current.tomorrow.to_date)
    .map { |o| r =  o.reservation_time; r.start_at == "10:00" && r.end_at == "10:30" }.include?(true) ? "x" : "o"
  end
  
  def day_after_tomorrow_seat_result(seat)
    seat.reservations.where(start_time: Time.current.ago(2.days).to_date)
    .map { |o| r =  o.reservation_time; r.start_at == "10:00" && r.end_at == "10:30" }.include?(true) ? "x" : "o"
  end
  
  def next_seat_result(seat)
    seat.reservations.where(start_time: Time.current.to_date)
    .map { |o| r =  o.reservation_time; r.start_at == "10:00" && r.end_at == "10:30" }.include?(true) ? "x" : "o"
  end
end
