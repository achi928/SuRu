class Admin::SearchesController < ApplicationController

  def search_group
    word = params[:word].to_s.strip # to_s は空文字が送られてきた時用
    if word.present? # wordが存在、空じゃないか
      @groups = Group.where('name LIKE ?', "%#{word}%").includes(:category)
    else
      @groups = Group.none
      flash[:alert] = '該当するグループはありません'
    end
  end

  def search_member
    word = params[:word].to_s.strip
    if word.present? 
      @members = Member.where('nickname LIKE ?', "%#{word}%")
    else
      @members = Member.none
      flash[:alert] = '該当する会員はいません'
    end
  end


end
