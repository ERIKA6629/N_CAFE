class Point < ApplicationRecord
  #attr_accessor :admin_id
  #attribute :admin_id
  belongs_to :customer
  
  after_save :points_to_coupon
  
  private
  
  def points_to_coupon
    customer = self.customer
    points = customer.points
    if points.size >= 10
      customer.coupons.create
      points.destroy_all
    end
  end
end
