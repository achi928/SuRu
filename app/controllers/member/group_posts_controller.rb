class Member::GroupPostsController < ApplicationController
  before_action :authenticate_member!
  before_action :active_membership?

  def create
    group_post = current_member.group_posts.new(group_post_params)
    group_post.group_id = @group.id
    group_post.save
    redirect_to group_my_membership_path(group_id: @group.id, member_id: current_member.id)
  end

  def edit
    @group_post = GroupPost.find(params[:id])
  end

  def update
    group_post = GroupPost.find(params[:id])
    if group_post.update(group_post_params)
      redirect_to group_my_membership_path(group_id: @group.id, member_id: current_member.id)
    else
      flash.now[:alert] = '投稿の編集に失敗しました'
      render :edit
    end
  end

  private

  def group_post_params
    params.require(:group_post).permit(:content, :post_image)
  end

  def active_membership?
    @group = Group.find(params[:group_id])
    unless @group.memberships.active.exists?(member_id: current_member.id)
      redirect_to mypage_path
    end
  end

end
