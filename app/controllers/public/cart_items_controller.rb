class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    flash[:notice] = "商品の追加に成功しました"
    redirect_to request.referer
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:alert] = "商品を削除しました"
    redirect_to request.referer
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    # current_customer.cart_items.destroy_all
    redirect_to root_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_items = current_customer.cart_items
    # カートに入れた商品が既に入っている場合、数量を
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        quantity = cart_item.quantity + @cart_item.quantity
        cart_item.update(:quantity => quantity)
        @cart_item.delete
      end
    end

    if @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to cart_items_path
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id,:item_id, :quantity)
  end

end
