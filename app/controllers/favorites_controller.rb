class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(special_id: params[:special_id])
    redirect_to specials_url, notice: "お気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to specials_url, notice: "お気に入り解除しました"
  end
end
