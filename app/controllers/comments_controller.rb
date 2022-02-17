class CommentsController < ApplicationController
  before_action :set_article

  def create
    @article.comments.create(comment_params)
    redirect_to article_path(@article), notice: t('app.create.success', model: Comment.model_name.human)
  end

  def destroy
    comment = @article.comments.find(params[:id])

    comment.destroy
    redirect_to article_path(@article), notice: t('app.destroy.success', model: Comment.model_name.human)
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commenter)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end