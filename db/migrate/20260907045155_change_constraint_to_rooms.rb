class ChangeConstraintToRooms < ActiveRecord::Migration[7.2]
  def change
    add_check_constraint :rooms, "price >= 1", name: "price_check"
  end
end
