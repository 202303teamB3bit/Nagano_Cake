class Public::CartItemsController < ApplicationController
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
    current_customer.cart_items.destroy_all
    redirect_to root_path
  end


  def create
    @cart_item = CartItem.new(cart_item_params)
    if
      @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to request.referer
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id,:item_id, :quantity)
  end

end
