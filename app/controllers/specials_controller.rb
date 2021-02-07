class SpecialsController < ApplicationController
  before_action :set_special, only: [:show, :edit, :update, :destroy]
  before_action :login_check, only: [:show]
  # before_action :authenticate_user!
  PER = 5

  def index
    @categories = Category.all
    @specials = Special.page(params[:page]).per(PER)
    @specials = @specials.order(updated_at: :desc)

    if params[:category_id].present?
  #presentメソッドでparams[:category_id]に値が含まれているか確認 => trueの場合下記を実行
      @category = Category.find(params[:category_id])
      @specials = @category.specials.page(params[:page]).per(PER)
    end

    if params[:sort_per_low]
      @specials = Special.page(params[:page]).per(PER)
      @specials = @specials.order(per: :asc)
    end

    if params[:sort_price_low]
      @specials = Special.page(params[:page]).per(PER)
      @specials = @specials.order(price: :asc)
    end
  end

  def new
    if current_user.try(:admin?)
      @special = Special.new
    else
      redirect_to specials_path, notice: "あなたは優待投稿ができません"
    end
  end

  def edit
    if current_user.try(:admin?)
      @special = Special.find(params[:id])
    else
      redirect_to specials_path, notice: "あなたは優待編集ができません"
    end
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
    # @special = Special.includes(:user).find(params[:id])
    if @special.update(special_params)
      redirect_to specials_path, notice: "優待記事を編集しました！"
    else
      render :edit
    end
  end

  def show
    @categories = Category.all
    @special = Special.find(params[:id])
    @favorite = current_user.favorites.find_by(special_id: @special.id)
    @comments = @special.comments
    @comment = @special.comments.build
    @suiis = @special.suiis
    if params[:category_id].present?
  #presentメソッドでparams[:category_id]に値が含まれているか確認 => trueの場合下記を実行
      @category = Category.find(params[:category_id])
      @specials = @category.specials
    end
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
    params.require(:special).permit(:product, :company, :detail, :per, :status, :price, :image, :image_cache, category_ids: [])
  end
  def set_special
    @special = Special.find(params[:id])
  end
  def login_check
    unless user_signed_in?
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end

end
