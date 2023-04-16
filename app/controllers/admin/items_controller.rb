class Admin::ItemsController < ApplicationController

  def new
    @imem = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.saved
    redirect_to root_path
  end

  def index
  end

  def show
  end

  def edit
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price)
  end

end
