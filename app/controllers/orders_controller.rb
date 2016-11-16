class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_order, only: [:show, :destroy]

  def index
    @orders = current_user.orders.all
  end

  def show
  end

  def new
  end

  def create
    if @cart.present?
      @order = current_user.orders.new order_params
      if @order.save
        session.delete :cart
        flash[:success] = t "order_create_succsess"
        redirect_to order_path @order
      else
        flash[:danger] = t "order_create_fails"
      end
    else
      flash[:danger] = t "cart_not_product"
      redirect_to carts_path
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "flash_success_destroy"
    else
      flash[:danger] = t "flash_fails_destroy"
    end
    redirect_to orders_path
  end

  private
  def order_params
    params.permit(:id).merge! cost: @cart.total_price, cart: @cart
  end

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "flash_danger_not_order"
      redirect_to root_path
    end
  end
end
