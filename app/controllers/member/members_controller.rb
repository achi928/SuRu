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
    if @member.update(is_active: false)
      @member.memberships.update_all(is_active: false)
      @member.change_group_owner
      #強制ログアウト
      reset_session
      flash[:notice] = 'お疲れ様でした！またいつでも戻ってきてね〜'
      redirect_to root_path
    else
      flash[:alert] = '退会処理に失敗しました'
      redirect_to mypage_path
    end
  end

  private

  def member_params
    params.require(:member).permit(:nickname, :gender, :birth_year, :profile_image, :email, :encrypted_password)
  end

  def set_member
    @member = current_member
  end

end
