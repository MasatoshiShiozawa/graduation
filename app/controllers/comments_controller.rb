class CommentsController < ApplicationController
  before_action :set_special, only: [:create, :edit, :update]
  def create
    @special = Special.find(params[:special_id])
    @comment = @special.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @special, notice: 'コメントが登録されました。' }
        # format.js { render :index }
      else
        format.html { redirect_to special_path(@special), notice: I18n.t('views.messages.failed_to_special') }
      end
    end
  end

  def edit
    @comment = @special.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @comment = Comment.find(params[:id])
    @special = @comment.special
    redirect_to special_path(@special) if @comment.update(comment_params)
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      respond_to do |format|
        format.js { render :index }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:special_id, :content)
  end
  def set_special
    @special = Special.find(params[:special_id])
  end
end
