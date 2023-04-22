class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @genres = Genre.all
    @q = Item.ransack(params[:q])
    @item = @q.result(distinct: true)
  end

  def show
    @item = Item.find(params[:id])
    @items = Item.all
    @cart_item = CartItem.new
    @genres = Genre.all
  end

end
