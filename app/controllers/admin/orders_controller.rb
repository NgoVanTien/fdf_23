class Admin::OrdersController < ApplicationController
  layout "admin_application"
  before_action :load_order, only: [:show, :destroy]

  def index
    @orders = Order.recent.page(params[:page]).per 3
  end

  def show
  end

  def update
    @orders = Order.find_by id: params[:id]
    respond_to do |format|
      if @orders.update_attributes order_params
        byebug
        UserMailer.welcome_email(current_user.id).deliver_later
        format.html
        format.json
        flash[:success] = t "flash.success_message"
      else
        format.html { render action: 'new' }
        format.json { render json: current_user.errors, status: :unprocessable_entity }
        flash[:danger] = t "flash.danger_message"
      end
      redirect_to admin_orders_path
    end
  end

  def destroy
    if @order.destroy
      flash[:success] = t "flash_success_destroy"
    else
      flash[:danger] = t "flash_fails_destroy"
    end
    redirect_to admin_orders_path
  end

  private
  def order_params
    params.require(:order).permit :is_accept
  end

  def load_order
    @order = Order.find_by id: params[:id]
    unless @order
      flash[:danger] = t "flash_danger_not_order"
      redirect_to root_path
    end
  end
end
