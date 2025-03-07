class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: [:edit, :update, :destroy]

  def create
    category = Category.create(category_params)
    flash[:notice] = 'カテゴリーを追加しました'
    redirect_to admin_categories_path
  end

  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit
  end

  def update
    @category.update(category_params)
    flash[:notice] = 'カテゴリーを編集しました'
    redirect_to admin_categories_path
  end

  def destroy
    @category.destroy
    flash[:notice] = 'カテゴリーを削除しました'
    redirect_to admin_categories_path
  end

  private
  
  def category_params
    params.require(:category).permit(:name, :category_image)
  end

  def set_category
    @category = Category.find(params[:id])
  end
  
end
