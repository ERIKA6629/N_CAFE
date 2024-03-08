class Reservation < ApplicationRecord
  
  belongs_to :customer
  belongs_to :seat
  belongs_to :reservation_time
  
  def self.display(seat, reservation_time)
    find_by(seat_id: seat, reservation_time_id: reservation_time)
  end
  
end
