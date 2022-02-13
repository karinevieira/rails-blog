class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @categories = Category.sorted
    category = @categories.select { |c| c.name == params[:category] }.first if params[:category].present?

    @highlights = Article.includes(:category)
                         .filter_by_category(category)
                         .desc_order
                         .first(3)
    
    current_page = (params[:page] || 1).to_i
    highlights_ids = @highlights.pluck(:id).join(',')

    @articles = Article.includes(:category)
                       .without_highlights(highlights_ids)
                       .filter_by_category(category)
                       .desc_order
                       .page(current_page)
                       .per(2)
    
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
 
    if @article.save
      redirect_to @article, notice: 'Artigo criado com sucesso!'
    else
      flash[:alert] = "Falha ao criar o artigo"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Artigo atualizado com sucesso!'
    else
      flash[:alert] = "Falha ao atualizar o artigo"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path, notice: 'Artigo excluído com sucesso!'
    else
      redirect_to root_path, notice: 'Falha ao excluir artigo'
    end
  end

  private
  
  def article_params
    params.require(:article).permit(:title, :body, :category_id)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
