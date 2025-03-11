class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    word = params[:word].to_s.strip # to_s は空文字が送られてきた時用
    if word.present? # wordが存在、空じゃないか
      @groups = Group.where('name LIKE ?', "%#{word}%").page(params[:page])
    else
      @groups = Group.all.page(params[:page])
    end
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
