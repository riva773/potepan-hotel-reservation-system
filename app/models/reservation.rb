class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :user_id, :hotel_id, :check_in, :check_out, :attendance, :sum_price, presence: true
end
