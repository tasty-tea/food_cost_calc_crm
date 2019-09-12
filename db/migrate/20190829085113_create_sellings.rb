# frozen_string_literal: true

class CreateSellings < ActiveRecord::Migration[5.2]
  def change
    create_table :sellings do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :amount, null: false, default: 0
      t.boolean :brake, null: false, default: false

      t.timestamps
    end
  end
end
