class Member::PostsController < ApplicationController
  before_action :authenticate_member!
  before_action :active_membership?

  def create
    @post = current_member.posts.new(post_params)
    @post.group_id = @group.id
    @post.save
    redirect_to group_path(@group.id)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash.now[:notice] = '投稿の編集をしました'
      redirect_to group_path(@group.id)
    else
      flash.now[:alert] = '投稿の編集に失敗しました'
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :post_image)
  end

  def active_membership?
    @group = Group.find(params[:group_id])
    unless @group.memberships.active.exists?(member_id: current_member.id)
      redirect_to mypage_path
    end
  end

end
