class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  def new
    @customer = current_customer
  end

  def create
  end

  def index
  end

  def show
  end

  def check
  end

  def complete
  end
end
