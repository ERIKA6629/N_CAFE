class ReservationTime < ApplicationRecord
  has_many :reservations
  
  enum business_hours: { before_opening: 0, open_n_cafe: 1, after_closing: 2}

end
