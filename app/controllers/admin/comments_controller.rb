class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    Comment.find_by(id: params[:id], member_id: params[:member_id]).destroy
    flash.now[:notice] = 'コメントを削除しました'
    redirect_to admin_member_path(params[:member_id])
  end
  

end
