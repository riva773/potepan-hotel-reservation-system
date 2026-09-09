class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, :room_id, :check_in, :check_out, :attendance, :sum_price, presence: true
  validates :attendance, numericality: { only_integer: true, greater_than: 0 }
  validate :checkout_must_be_after_checkin
  validate :checkin_must_be_after_today
  before_validation :calculate_sum_price

  private
  def checkout_must_be_after_checkin
    return if check_in.blank? || check_out.blank?
    if check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付を選択してください。")
    end
  end

  def checkin_must_be_after_today
    return if check_in.blank?
    if check_in < Time.zone.today
      errors.add(:check_in, "は、今日以降の日付を選択してください。")
    end
  end

  def calculate_sum_price
    return unless room.present?
    return unless check_in.present?
    return unless check_out.present?
    return unless attendance.present?

    self.sum_price = room.price * attendance * (check_out - check_in).to_i
  end
end
