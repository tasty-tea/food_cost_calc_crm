# frozen_string_literal: true

class FixedCostsController < ApplicationController
  before_action :set_fixed_cost, only: %i[show edit update destroy]

  def index
    @fixed_costs = FixedCost.all
  end

  def show; end

  def new
    @fixed_cost = FixedCost.new
  end

  def edit; end

  def create
    @fixed_cost = FixedCost.new

    if @fixed_cost.save
      redirect_to @fixed_cost
    else
      render :new
    end
  end

  def update
    if @fixed_cost.update(fixed_cost_params)
      redirect_to @fixed_cost
    else
      render :edit
    end
  end

  def destroy
    @fixed_cost.destroy
    redirect_to fixed_costs_path
  end

  private

  def set_fixed_cost
    @fixed_cost = FixedCost.find(params[:id])
  end

  def fixed_cost_params
    params.require(:fixed_cost).permit(:number)
  end
end
