class Member::MembershipsController < ApplicationController
  before_action :authenticate_member!

  def create
    group = Group.find(params[:group_id])
    membership = Membership.create!(group_id: group.id, member_id: current_member.id)
    redirect_to group_membership_path(group.id, membership.id)
  end
  
  def show
    @group = Group.find(params[:group_id])
    @membership = Membership.find(params[:id])
  end

  def destroy
    membership = Membership.find(params[:id])
    if membership.destroy
      flash[:notice] = '退会しました'
      redirect_to mypage_path
    else
      flash.now[:alert] = '退会に失敗しました'
      render :show
    end
  end
  

end
