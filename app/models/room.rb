class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :avatar

  validates :name, :price, :address, :description, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }
end
