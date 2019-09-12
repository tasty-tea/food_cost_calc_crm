# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :cost, default: 0, null: false
      t.integer :servings, default: 1, null: false
      t.integer :estimated_sold, default: 0, null: false
      t.boolean :is_unit_economics, default: false, null: false

      t.timestamps
    end
  end
end
