class Hotel < ApplicationRecord
  belongs_to :user
  has_many :reservations
  has_one_attached :avatar

  validates :name, :price, :address, :description, presence: true
  validates :name, uniqueness: true
end
