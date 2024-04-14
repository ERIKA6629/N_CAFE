class Menu < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  validate :image_size
  
  validates :image, presence: true
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  
  def include_tax
    (price * 1.1).floor
  end
  
  private
  
  def image_size
    if image.blob.byte_size > 4.megabytes
      errors.add(:image, "は1つのファイル5MB以内にしてください")
    end
  end
  
end
