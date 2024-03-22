class Customer < ApplicationRecord
  after_update :check_customer_is_active
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  scope :admin, -> { find_by(email: 'n_cafe@example.com') }
  
  has_many :reservations
  has_many :points
  has_many :coupons
         
  validates :email, uniqueness: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :email, presence: true
  validates :telephone_number, presence: true
  
  GUEST_USER_EMAIL = "guest@example.com"
  
  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.last_name = "guest"
      customer.first_name = "user"
      customer.last_name_kana = "ゲスト"
      customer.first_name_kana = "ユーザー"
      customer.telephone_number = "99999999999"
    end
  end
  
  def guest_user?
    email == GUEST_USER_EMAIL
  end
  
  def check_customer_is_active
    if is_active == false
      Point.where(customer_id: id).destroy_all
      coupons = Coupon.where(customer_id: id, is_active: true)
      coupons.each do |coupon|
        coupon.is_active = false
        coupon.save
      end
    end
  end
  
end
