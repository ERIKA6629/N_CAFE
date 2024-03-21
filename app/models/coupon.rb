class Coupon < ApplicationRecord
  belongs_to :customer
  
  def self.create_coupon(customer_id)
    coupon = Coupon.new(customer_id: customer_id)
    coupon.save
  end
end
