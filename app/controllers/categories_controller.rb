class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.sorted
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, notice: t('app.create.success', model: Category.model_name.human)
    else
      flash[:alert] = t('app.create.error', model: Category.model_name.human)
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, notice: t('app.update.success', model: Category.model_name.human)
    else
      flash[:alert] = t('app.update.error', model: Category.model_name.human)
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: t('app.destroy.success', model: Category.model_name.human)
    else
      redirect_to categories_path, alert: @category.errors.messages[:base][0]
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end