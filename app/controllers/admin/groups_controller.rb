class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.includes(:category).page(params[:page])
  end

  def show
    @group = Group.find(params[:id])
  end


  def destroy
    @group = Group.find(params[:id])
    if @group.destroy
      flash[:notice] = 'グループを削除しました'
    else
      flash[:alert] = 'グループの削除に失敗しました'
    end
    redirect_to admin_groups_path
  end
  


end
