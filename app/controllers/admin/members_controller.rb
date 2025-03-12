class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_member, only: [:show, :withdraw]

  def show
  end

  def withdraw
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

  def search
    word = params[:word].to_s.strip # to_s は空文字が送られてきた時用
    if word.present? # wordが存在、空じゃないか
      @search = Member.where('nickname LIKE ?', "%#{word}%").page(params[:page])
    else
      @search = Member.none
    end
  end
  

  private

  def set_member
    @member = Member.find(params[:id])
  end
end
