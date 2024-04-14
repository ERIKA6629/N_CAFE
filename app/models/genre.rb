class Genre < ApplicationRecord
  has_one_attached :image
  has_many :menus, -> { order "name DESC" }, dependent: :destroy
  
  validates :name, presence: true
  validates :image, presence: true
end
