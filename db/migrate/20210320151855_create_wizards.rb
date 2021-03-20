class CreateWizards < ActiveRecord::Migration[6.1]
  def change
    create_table :wizards do |t|
      t.string :name, null: false
      t.integer :gender, null: false
      t.float :location_x, null: false
      t.float :location_y, null: false
      t.integer :gold, null: false, default: 0

      t.timestamps
    end
  end
end
