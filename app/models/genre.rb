class Genre < ApplicationRecord
  has_one_attached :image
  has_many :menus, -> { order "name DESC" }
  
  validates :name, presence: true
  validates :image, presence: true
end
