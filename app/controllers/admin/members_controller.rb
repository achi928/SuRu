class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @member = Member.includes(:comments).find(params[:id])
  end

  def withdraw
    @member = Member.find(params[:id])
    if @member.update(is_active: false)
      @member.memberships.update_all(is_active: false)
      @member.change_group_owner
      flash[:notice] = "#{@member.nickname}さんを退会済みにしました"
      redirect_to admin_root_path
    else
      flash[:alert] = '退会処理に失敗しました'
      redirect_to admin_member_path(@member.id)
    end
  end

end
