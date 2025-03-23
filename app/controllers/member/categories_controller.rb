class Member::CategoriesController < ApplicationController
  before_action :authenticate_member!

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @category_groups = @category.groups
  end
end