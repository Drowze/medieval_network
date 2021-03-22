class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :value, null: false
      t.timestamps
    end

    create_table :item_slots do |t|
      t.integer :quantity, null: false
      t.references :wizard, null: false
      t.references :item, null: false
    end
  end
end
