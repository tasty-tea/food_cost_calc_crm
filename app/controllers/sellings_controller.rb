# frozen_string_literal: true

class SellingsController < ApplicationController
  before_action :set_selling, only: %i[show edit update destroy]
  before_action :set_product, only: %i[show]

  def index
    @sellings = Selling.all
  end

  def search
    date_selected = Date.parse(params[:date_selected])
    @sellings = if date_selected
                  Selling.where_date(date_selected)
                else
                  Selling.all
                end
    render 'search'
  end

  def show; end

  def new
    @selling = Selling.new
  end

  def edit; end

  def create
    result = Sellings::Create.call(current_user, selling_params.to_h)
    @selling = result.object

    if result.success?
      redirect_to @selling
    else
      render :new, alert: t('.failure')
    end
  end

  def update
    if @selling.update(selling_params)
      redirect_to @selling
    else
      render :edit, alert: t('.failure')
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
    @set_selling unless @selling
    @product = @selling.product
  end

  def selling_params
    params.require(:selling).permit(:product_id, :amount, :brake, :user_id)
  end
end
