class Public::GenresController < ApplicationController

  def show
    @genre = Genre.find_by(id: params[:id])
    if @genre
      @items = @genre.item
    else
      flash[:alert] = "指定されたジャンルが見つかりませんでした。"
      redirect_to root_path
    end
  end
end
