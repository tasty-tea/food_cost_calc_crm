class CreateStockMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_movements do |t|

      t.references :stock_unit, null: false, foreign_key: true
      t.integer :amount, default: 0, null: false
      t.decimal :cost, default: 0, null: false
      t.string :measure_units, default: ''
      t.boolean :brake, null: false, default: false
      
      t.timestamps
    end
  end
end
