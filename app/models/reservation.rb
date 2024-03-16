class Reservation < ApplicationRecord
  
  before_create :check_create_reservation
  
  belongs_to :customer
  belongs_to :seat
  belongs_to :reservation_time
  
  validates :number_of_people, presence: true
  
  def self.display_reservation(seat, reservation_time, start_time)
    find_by(seat_id: seat, reservation_time_id: reservation_time, start_time: start_time)
  end
  
  def self.my_reservations(current_customer)
    where(customer_id: current_customer).where("start_time >= ?", Date.current)
  end
  
  private
  
    def check_create_reservation
      non_business_day = 4
      throw :abort if Reservation.find_by(seat_id: seat_id, reservation_time_id: reservation_time_id, start_time: start_time) || start_time.wday == non_business_day
    end
  
  
end
