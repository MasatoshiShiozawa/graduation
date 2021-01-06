class SpecialsController < ApplicationController
  before_action :set_special, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @specials = Special.all
  end
  def new
    @special = Special.new
  end
  def edit
    @special = Special.find(params[:id])
  end
  def create
    @special = Special.new(special_params)
    if params[:back]
      render :new
    else
      if @special.save
        redirect_to specials_path, notice: "優待記事を作成しました！"
      else
        render :new
      end
    end
  end
  def update
    @special = Special.find(params[:id])
    if @special.update(special_params)
      redirect_to specials_path, notice: "優待記事を編集しました！"
    else
      render :edit
    end
  end
  def show
    @special = Special.find(params[:id])
    @favorite = current_user.favorites.find_by(special_id: @special.id)
    @comments = @special.comments.includes(:user).all
    @comment = @special.comments.build
  end
  def destroy
    @special.destroy
    redirect_to specials_path, notice:"優待記事を削除しました！"
  end
  def confirm
    @special = Special.new(special_params)
    render :new if @special.invalid?
  end


  private
  def special_params
    params.require(:special).permit(:product, :company, :detail, :per, :status, :price, :image, :image_cache)
  end
  def set_special
    @special = Special.find(params[:id])
  end
end
