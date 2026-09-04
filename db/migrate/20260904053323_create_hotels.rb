class CreateHotels < ActiveRecord::Migration[7.2]
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.string :address, null: false
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :hotels, :name, unique: true
  end
end
