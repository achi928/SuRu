class Member::CommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :find_post

  def new
    group = @post.group
    if @post.member_id == current_member.id || !current_member.memberships.active.exists?(group_id: group.id)
      redirect_to mypage_path
    end
    @comment = Comment.new
  end

  def create
    group = @post.group
    @comment = current_member.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash[:notice] = 'コメントしました！'
      redirect_to group_path(group.id)
    else
      flash.now[:alert] = 'コメントに失敗しました。'
      render :new
    end
  end

  def index
    @comments = @post.comments
    unless current_member.id == @post.member.id
      redirect_to mypage_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end


end
