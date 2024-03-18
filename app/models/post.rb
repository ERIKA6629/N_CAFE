class Post < ApplicationRecord
  has_one_attached :image
  
  validates :image, presence: true
  validates :title, presence: true
  validates :content, presence: true
  
  private

end
