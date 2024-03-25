class Menu < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  def include_tax
    (price * 1.1).floor
  end
end
