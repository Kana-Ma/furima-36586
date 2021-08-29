class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :check_soldout, only: [:new, :create]
  before_action :check_self_item, only: [:new, :create]
  before_action :set_item, only: [:new, :create]

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def check_soldout
    if Order.exists?(item_id: params[:item_id])
      redirect_to root_path
    end
  end

  def check_self_item
    if Item.find_by(id: params[:item_id]).user_id == current_user.id
      redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
