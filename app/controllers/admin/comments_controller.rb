class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @member = Member.find(params[:member_id])
    @comments = @member.comments
  end

  def destroy
    comment = Comment.find_by(id: params[:id], member_id: params[:member_id])
    if comment.destroy
      flash[:notice] = 'コメントを削除しました'
    else
      flash[:alert] = 'コメントの削除に失敗しました'
    end
    redirect_to admin_member_comments_path(params[:member_id])
  end
  

end
