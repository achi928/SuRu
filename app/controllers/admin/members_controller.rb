class Admin::MembersController < ApplicationController
  before_action :set_member, only: [:show, :withdraw]



  def show
  end

  def withdraw
    if @member.update(is_active: false)
      flash[:notice] = "#{@member.nickname}さんを退会させました"
      redirect_to admin_root_path
    else
      flash[:alert] = "退会処理に失敗しました"
      redirect_to admin_member_path(@member)
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end
end
