class Menu < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
end
