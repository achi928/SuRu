class Member::GroupsController < ApplicationController

  def search
    word = params[:word].to_s.strip # to_s は空文字が送られてきた時用
    if word.present? # wordが存在、空じゃないか
      @search_groups = Group.where('name LIKE ?', "%#{word}%").page(params[:page])
    else
      @search_groups = Group.none
    end
  end

end
