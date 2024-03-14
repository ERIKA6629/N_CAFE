class ReservationTime < ApplicationRecord
  has_many :reservations
  
  enum business_hours: { before_opening: 0, open_n_cafe: 1, after_closing: 2}
  
  def self.search_display_time
    arr = []
    ReservationTime.all.each do |reservation_time|
      start_time_obj = Time.zone.parse("#{Date.current.to_s} #{reservation_time.start_at}")
      end_time_obj = Time.zone.parse("#{Date.current.to_s} #{reservation_time.end_at}")
      if Date.today.wday == 4
        reservation_time.business_hours = "after_closing"
        arr << reservation_time
      elsif Time.current.beginning_of_day < Time.current && Time.current < start_time_obj 
        reservation_time.business_hours = "before_opening"
        arr << reservation_time
      elsif start_time_obj <= Time.current && Time.current < end_time_obj
        reservation_time.business_hours = "open_n_cafe"
        arr << reservation_time
      elsif end_time_obj <= Time.current && Time.current < Time.current.end_of_day
        reservation_time.business_hours = "after_closing"
        arr << reservation_time
      end
    end
    arr[0]
  end
  
end
