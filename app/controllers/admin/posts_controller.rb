class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @member = Member.find(params[:member_id])
    @posts = @member.posts
  end

  def destroy
    post = Post.find_by(id: params[:id], member_id: params[:member_id])
    if post.destroy
      flash[:notice] = '投稿を削除しました'
    else
      flash[:alert] = '投稿の削除に失敗しました'
    end
    redirect_to admin_member_posts_path(params[:member_id])
  end

end
