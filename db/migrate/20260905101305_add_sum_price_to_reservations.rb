class AddSumPriceToReservations < ActiveRecord::Migration[7.2]
  def change
    add_column :reservations, :sum_price, :integer, null: false
  end
end
