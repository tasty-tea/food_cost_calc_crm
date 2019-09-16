# frozen_string_literal: true

class StockUnitsController < ApplicationController
  before_action :set_stock_unit, only: %i[show edit update destroy]

  def index
    @stock_units = StockUnit.all
  end

  def show; end

  def new
    @stock_unit = StockUnit.new
  end

  def edit; end

  def create
    @stock_unit = StockUnit.new(stock_unit_params)

    if @stock_unit.save
      redirect_to @stock_unit, notice: 'Stock unit wasa successfully creaeted'
    else
      render :new, alert: t('.failure')
    end
  end

  def update
    if @stock_unit.update(stock_unit_params)
      redirect_to @stock_unit, notice: 'Stock unit was successfully updated'
    else
      render :edit, alert: t('.failure')
    end
  end

  def destroy
    @stock_unit.destroy
    redirect_to stock_units_path, notice: 'Stock unit was successfully destroyed'
  end

  private

  def set_stock_unit
    @stock_unit = StockUnit.find(params[:id])
  end

  def stock_unit_params
    params.require(:stock_unit).permit(:name, :amount, :rejected, :cost, :measure_units)
  end
end
