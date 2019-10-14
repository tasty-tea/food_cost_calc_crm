class AddSellingKeyToStockMovements < ActiveRecord::Migration[5.2]
  def change
    add_reference :stock_movements, :selling, null: true
  end
end
