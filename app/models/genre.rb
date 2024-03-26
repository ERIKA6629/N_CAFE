class Genre < ApplicationRecord
  has_one_attached :image
  has_many :menus, -> { order "name DESC" }
end
