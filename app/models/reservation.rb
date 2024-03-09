class Reservation < ApplicationRecord
  
  belongs_to :customer
  belongs_to :seat
  belongs_to :reservation_time
  
  validates :number_of_people, presence: true
  
  def self.display(seat, reservation_time, start_time)
    find_by(seat_id: seat, reservation_time_id: reservation_time, start_time: start_time)
  end
  
end
