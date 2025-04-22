class Member::CategoriesController < ApplicationController
  before_action :authenticate_member!

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    # カテゴリー１に対して、グループが多だからN+1回避
    @category_groups = @category.groups
  end
end