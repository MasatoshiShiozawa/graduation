class CommentsController < ApplicationController
  before_action :set_special, only: [:create, :edit, :update]
  def create
    @special = Special.find(params[:special_id])
    @comment = @special.comments.build(comment_params)
    @comment.user_id = current_user.id
    respond_to do |format|
      if @comment.save
        # format.html { redirect_to @special, notice: 'コメントが登録されました。' }
        format.js { render :index }
      else
        format.html { redirect_to special_path(@special), notice: 'コメントが登録できませんでした。' }
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
    @comment = @special.comments.find(params[:id])
    # @special = @comment.special
    respond_to do |format|
      if @comment.update(comment_params)
        # redirect_to special_path(@special), notice: 'コメントが更新されました。'
        flash.now[:notice] = 'コメントが編集されました'
        format.js { render :index }
      else
        flash.now[:notice] = 'コメントの編集に失敗しました'
        format.js { render :edit_error }
      end
    end
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
