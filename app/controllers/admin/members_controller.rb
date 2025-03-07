class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_member, only: [:show, :withdraw]

  def show
  end

  def withdraw
    @member.update(is_active: false)
    flash[:notice] = '#{@member.nickname}さんを退会済みにしました'
    redirect_to admin_root_path
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end
end
