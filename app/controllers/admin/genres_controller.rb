class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page])
  end


  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    flash[:notice] = '削除が完了しました'
    redirect_to admin_genres_path
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "登録が完了しました"
      redirect_to admin_genres_path
    else
      flash[:alert] = "登録に失敗しました"
      # redirect_to admin_genres_path
      @genres = Genre.page(params[:page])
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "変更が完了しました"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end
