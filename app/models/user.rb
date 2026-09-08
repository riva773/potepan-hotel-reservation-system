class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :name, length: { maximum: 50 }
  validates :introduction, length: { maximum: 500 }
  validates :avatar, content_type: [ :png, :jpg, :jpeg ]
  
  has_many :rooms
  has_many :reservations
  has_one_attached :avatar
end
