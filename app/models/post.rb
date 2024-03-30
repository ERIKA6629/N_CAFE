class Post < ApplicationRecord
  has_one_attached :image
  
  validates :image, presence: true
  validates :title, presence: true
  validates :content, presence: true, length: { maximum: 150 }
  
  private

end
