module Public::ReservationsHelper
  
  def for_showing_reservations(day, start_at)
    reservation_time_obj = Time.zone.parse("#{day.to_s} #{start_at.to_s}")
    return true if Time.current < reservation_time_obj && reservation_time_obj < Time.current.since(1.month)
  end
end
