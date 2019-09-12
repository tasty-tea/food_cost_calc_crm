# frozen_string_literal: true

class CreateFixedCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :fixed_costs do |t|
      t.string :name, null: false
      t.decimal :cost, null: false, default: 0.0
      t.integer :frequency, null: false, default: 0
      t.datetime :date_started
      t.datetime :date_finished

      t.timestamps
    end
  end
end
