# frozen_string_literal: true

class IngredientsController < ApplicationController
  before_action :set_product, only: %i[index destroy create update]
  before_action :set_ingredient, only: %i[update destroy]

  def index
    @product.ingredients
  end

  def create
    @ingredient = @product.ingredients.build(ingredient_params)

    if @ingredient.save
      redirect_to request.referer, notice: t('.success')
    else
      redirect_to request.referer, alert: t('.failure')
    end
  end

  def update
    if @ingredient.update(ingredient_update_params)
      redirect_to request.referer, notice: t('.success')
    else
      redirect_to request.referer, alert: t('.failure')
    end
  end

  def destroy
    if @ingredient.destroy
      redirect_to request.referer, notice: t('.success')
    else
      redirect_to request.referer, alert: t('.failure')
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_ingredient
    @product.ingredients.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:stock_unit_id, :amount)
  end

  def ingredient_update_params
    params.require(:ingredient).permit(:amount)
  end
end
