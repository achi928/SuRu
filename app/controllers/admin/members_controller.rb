class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_member, only: [:show, :withdraw]

  def show
  end

  def withdraw
    @member.update(is_active: false)
    flash[:notice] = "#{@member.nickname}さんを退会済みにしました"
    redirect_to admin_root_path
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
