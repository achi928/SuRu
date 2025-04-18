class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: [:edit, :update, :destroy]

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'カテゴリーを追加しました'
      redirect_to admin_categories_path
    else
      flash.now[:alert] = 'カテゴリーの追加に失敗しました'
      @categories = Category.all
      render :index
    end
  end

  def index
    @category = Category.new
    @categories = Category.all
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = 'カテゴリーを編集しました'
      redirect_to admin_categories_path
    else
      flash.now[:alert] = 'カテゴリーの編集に失敗しました'
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'カテゴリーを削除しました'
      redirect_to admin_categories_path
    else
      flash.now[:alert] = 'カテゴリーの編集に失敗しました'
      @categories = Category.all
      render :index
    end
  end

  private
  
  def category_params
    params.require(:category).permit(:name, :category_image)
  end

  def set_category
    @category = Category.find(params[:id])
  end
  
end
