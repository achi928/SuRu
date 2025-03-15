class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    # 会員一覧と検索結果同じページ
    word = params[:word].to_s.strip # to_s は空文字が送られてきた時用
    if word.present? # wordが存在、空じゃないか
      @members = Member.where('nickname LIKE ?', "%#{word}%").page(params[:page])
    else
      @members = Member.all.page(params[:page])
    end
  end
  
end
