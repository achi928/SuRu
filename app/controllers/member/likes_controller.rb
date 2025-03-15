class Member::LikesController < ApplicationController
  before_action :authenticate_member!

  def create
    post = Post.find(params[:post_id])
    group = Group.find(post.group_id)  # その投稿のグループを取得
    current_member.likes.create(post_id: post.id)
    redirect_to group_path(group.id)
  end

end
