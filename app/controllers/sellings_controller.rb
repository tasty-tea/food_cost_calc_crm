# frozen_string_literal: true

class SellingsController < ApplicationController
  before_action :set_selling, only: %i[show edit update destroy]
  before_action :set_product, only: %i[show]

  def index
    @sellings = Selling.all
  end

  def show; end

  def new
    @selling = Selling.new
  end

  def edit; end

  def create
    @selling = Selling.new(selling_params)
    @selling.user_id ||= current_user.id

    if @selling.save
      redirect_to @selling
    else
      render :new
    end
  end

  def update
    if @selling.update(selling_params)
      redirect_to @selling
    else
      render :edit
    end
  end

  def destroy
    @selling.destroy
    redirect_to sellings_path
  end

  private

  def set_selling
    @selling = Selling.find(params[:id])
  end

  def set_product
    @set_selling if !@selling
    @product = @selling.product
  end

  def selling_params
    params.require(:selling).permit(:product_id, :amount, :brake, :user_id)
  end
end
