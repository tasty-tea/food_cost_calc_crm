# frozen_string_literal: true
class StockMovementsController < ApplicationController

  before_action :set_stock_unit, only: %i[index destroy create]
  before_action :set_stock_movement, only: %i[update destroy]

  def index
    @stock_unit.stock_movements
  end

  def create
    @stock_movement = StockMovement.new(stock_movement_params.merge(stock_unit_id: @stock_unit.id))

    if @stock_movement.save
      redirect_to request.referer, notice: t('.success')
    else
      redirect_to request.referer, alert: t('.failure')
    end
  end

  def update
    if @stock_movement.update(stock_movement_update_params)
      redirect_to request.referer, notice: t('.success')
    else
      redirect_to request.referer, alert: t('.failure')
    end
  end

  def destroy
    if @stock_movement.destroy
      redirect_to request.referer, notice: t('.success')
    else
      redirect_to request.referer, alert: t('.failure')
    end
  end

  private

  def set_stock_unit
    @stock_unit = StockUnit.find(params[:stock_unit_id])
  end

  def set_stock_movement
    @stock_movement = StockMovement.find(params[:id])
  end

  def stock_movement_params
    params.require(:stock_movement).permit(:stock_unit_id, :amount, :cost, :measure_units)
  end

  def stock_movement_update_params
    params.require(:stock_movement).permit(:amount, :cost, :measure_units)
  end

end
