# frozen_string_literal: true

class CreateIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :ingredients do |t|
      t.references :stock_unit, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :amount, default: 0, null: false

      t.timestamps
    end
  end
end
