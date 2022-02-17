class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update]
  
  def index
    @categories = Category.sorted
    category = @categories.select { |c| c.name == params[:category] }.first if params[:category].present?

    @highlights = Article.includes(:category)
                         .filter_by_category(category)
                         .filter_by_archive(params[:month_year])
                         .desc_order
                         .first(3)
    
    current_page = (params[:page] || 1).to_i
    highlights_ids = @highlights.pluck(:id).join(',')

    @articles = Article.includes(:category)
                       .without_highlights(highlights_ids)
                       .filter_by_category(category)
                       .filter_by_archive(params[:month_year])
                       .desc_order
                       .page(current_page)
                       .per(10)

    @archives = Article.group_by_month(:created_at, format: '%B %Y', locale: :en).count
    
  end

  def show
    @article = Article.includes(:comments).find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
 
    if @article.save
      redirect_to @article, notice: t('.success')
    else
      flash[:alert] = "Falha ao criar o artigo"
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: t('.success')
    else
      flash[:alert] = "Falha ao atualizar o artigo"
      render :edit
    end
  end

  def destroy
    if @article.destroy
      redirect_to root_path, notice: t('.success')
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

  def set_categories
    @categories = Category.sorted
  end
end
