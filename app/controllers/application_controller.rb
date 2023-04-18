class ApplicationController < ActionController::Base
  before_action :set_genres

  private

  # 全てのコントローラでジャンルデータを利用できるようにするため
  def set_genres
    @genres = Genre.all
  end



end

