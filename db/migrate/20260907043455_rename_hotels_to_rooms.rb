class RenameHotelsToRooms < ActiveRecord::Migration[7.2]
  def change
    rename_table :hotels, :rooms
    rename_column :reservations, :hotel_id, :room_id
  end
end
