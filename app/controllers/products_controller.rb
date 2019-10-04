# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all.ordered
  end

  def show
    @stock_units = StockUnit.all
  end

  def new
    @stock_units = StockUnit.all
    @product = Product.new
  end

  def edit
    @stock_units = StockUnit.all
  end

  def create
    @product = Product.new(product_params.except(:ingredients))

    if @product.save
      redirect_to @product, notice: t('.success')
    else
      render :new, alert: t('.failure')
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: t('.success')
    else
      render :edit, alert: t('.failure')
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path, alert: t('.success')
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :cost, :servings, :estimated_sold, :is_unit_economics,
                                    ingredients: %i[stock_unit_id amount])
  end
end
