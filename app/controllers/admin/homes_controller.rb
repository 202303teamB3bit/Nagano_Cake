class Admin::HomesController < ApplicationController

  def top
    @orders = Order.all
    @quantity = 0
  end

end
