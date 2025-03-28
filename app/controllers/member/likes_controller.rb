class Member::LikesController < ApplicationController
  before_action :authenticate_member!
  before_action :active_membership?

  def create
    current_member.likes.create(post_id: @post.id)
  end

  private

  def active_membership?
    @post = Post.find(params[:post_id])
    @group= @post.group
    unless @group.memberships.active.exists?(member_id: current_member.id)
      redirect_to mypage_path
    end
  end

end
