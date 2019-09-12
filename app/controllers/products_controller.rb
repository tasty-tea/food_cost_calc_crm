# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]

  def index
    @products = Product.all.ordered
  end

  def show; end

  def new
    @stock_units = StockUnit.all
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params.except(:ingredients))
    @product.ingredients.build(product_params[:ingredients]) if product_params[:ingredients]

    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
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
