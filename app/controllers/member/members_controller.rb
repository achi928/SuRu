class Member::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :set_member, only: [:mypage, :edit, :update, :unsubscibe, :withdraw]

  def mypage
    Membership.find_by(member_id: current_member.id, group_id: group.id)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
  end

  def update
    if @member.update(member_params)
      flash[:notice] = 'プロフィールを更新しました'
      redirect_to mypage_path
    else
      flash.now[:alert] = 'プロフィールの更新に失敗しました'
      render :edit
    end
  end

  def unsubscibe
  end

  def withdraw
    @member.update(is_active: false)
    #強制ログアウト
    reset_session
    flash[:notice] = 'いつでも戻ってきてね、またね〜'
    redirect_to root_path
  end

  private

  def member_params
    params.require(:member).permit(:nickname, :gender, :birth_year, :profile_image, :email, :encrypted_password)
  end

  def set_member
    @member = current_member
  end

end
