class Member::CommentsController < ApplicationController
  before_action :authenticate_member!

  def new
    post = Post.find(params[:post_id])
    group = post.group
    unless current_member.memberships.active.exists?(group_id: group.id)
      redirect_to mypage_path
    end
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    group = post.group
    comment = current_member.comments.new(comment_params)
    comment.post_id = post.id
    unless comment.save
      flash[:alert] = 'コメントに失敗しました。'
    end
    redirect_to group_path(group.id)
  end

  def index
    @post = Post.find(params[:post_id])
    unless current_member.id == @post.member.id
      redirect_to mypage_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
