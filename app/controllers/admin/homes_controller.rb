class Admin::HomesController < ApplicationController
  def top
    @users = User.all.page(params[:page])
  end
end
