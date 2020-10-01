class LineItemsController < ApplicationController
  include CurrentCart

  before_action :set_line_item, only: %i[show edit update destroy]
  before_action :set_cart, only: :create
  skip_before_action :authenticate_user!

  def index
    @line_items = LineItem.all
  end

  def show; end

  def new
    @line_item = LineItem.new
  end

  def edit; end

  def create
    set_cart
    item = Item.find(params[:item_id])
    @line_item = @cart.add_item(item)
    if @line_item.save
      redirect_to cart_path(@cart),
                  alert: 'Woohoo! You added an item to your cart.'
    else
      render :new
    end
  end

  def update
    if @line_item.update(line_item_params)
      redirect_to @line_item, alert: 'Great! You added an item to your Menu.'
    else
      render :edit
    end
  end

  def destroy
    @cart = Cart.find(session[:cart_id])
    @line_item.destroy
    redirect_to cart_path(@cart), alert: 'You removed an item!'
  end

  private

  def set_line_item
    @line_item = LineItem.find(params[:id])
  end

  def line_item_params
    params.require(:line_item).permit(:item_id)
  end
end
