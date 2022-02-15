class CommentsController < ApplicationController
  before_action :set_article

  def create
    @article.comments.create(comment_params)
    redirect_to article_path(@article), notice: 'Comentário criado com sucesso!'
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end
end