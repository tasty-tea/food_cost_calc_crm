# frozen_string_literal: true

class CreateStockUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :stock_units do |t|
      t.string :name, null: false
      t.integer :amount, default: 0, null: false
      t.integer :rejected, default: 0, null: false
      t.decimal :cost, default: 0, null: false
      t.string :measure_units, default: 'pieces'

      t.timestamps
    end
  end
end
