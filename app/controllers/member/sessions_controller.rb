# frozen_string_literal: true

class Member::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_member, only: [:create]

  def after_sign_in_path_for(resource)
    mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  private

  def reject_inactive_member      
    member = Member.find_by(email: params[:member][:email])
    # メールアドレスに対応する会員がいない場合
    unless member
      return
    end
    # パスワードが一致しない場合
    unless member.valid_password?(params[:member][:password])
      return
    end
    # 退会済み
    unless member.is_active
      flash[:danger] = 'お客様は退会済みです。'
      redirect_to new_member_session_path
    end
  end
end
