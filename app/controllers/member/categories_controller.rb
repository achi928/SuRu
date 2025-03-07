class Member::CategoriesController < ApplicationController
  before_action :authenticate_member!

  def index
    @categories = Category.all
  end

  def groups
    @category = Category.find(params[:id])
  end

end
