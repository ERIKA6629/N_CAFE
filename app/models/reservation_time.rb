class ReservationTime < ApplicationRecord
  has_many :reservations
  
  def self.search_display_time
    arr = []
    ReservationTime.all.each do |reservation_time|
      start_time_obj = Time.zone.parse("#{Date.current.to_s} #{reservation_time.start_at}")
      end_time_obj = Time.zone.parse("#{Date.current.to_s} #{reservation_time.end_at}")
      if start_time_obj <= Time.current && Time.current < end_time_obj
        arr << reservation_time
      end
    end
    arr[0]
  end
end
