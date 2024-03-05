class Reservation < ApplicationRecord
  
  belongs_to :customer
  belongs_to :seat
  belongs_to :reservation_time
  
end
