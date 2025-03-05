class Member::MembersController < ApplicationController

  before_action :authenticate_member!
  before_action :set_member, only: [:mypage, :edit, :update, :unsubscibe, :withdraw]

  def mypage
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
  end

  def update
    if @member.update(member_params)
      flash[:notice] = "プロフィールを更新しました"
      redirect_to mypage_path
    else
      flash[:alert] = "プロフィールの更新に失敗しました"
      render :edit
    end
  end

  def unsubscibe
  end

  def withdraw
  end

  private

  def member_params
    params.require(:member).permit(:nickname, :gender, :birth_year, :profile_image, :email, :encrypted_password)
  end

  def set_member
    @member = current_member
  end

end
