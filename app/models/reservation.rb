class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, :room_id, :check_in, :check_out, :attendance, :sum_price, presence: true
  validates :attendance, numericality: { only_integer: true, greater_than: 0 }
  validate :checkout_must_be_after_checkin
  validate :checkin_must_be_after_today

  private
  def checkout_must_be_after_checkin
    return if check_in.blank? | check_out.blank?
    if check_out <= check_in
      errors.add(:check_out, "はチェックイン日より後の日付を選択してください。")
    end
  end

  def checkin_must_be_after_today
    return if check_in.blank? | check_out.blank?
    if check_in < Date.today
      errors.add(:check_in, "は、今日以降の日付を選択してください。")
    end
  end
end
