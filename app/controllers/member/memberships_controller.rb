class Member::MembershipsController < ApplicationController
  before_action :authenticate_member!

  def create
    group = Group.find(params[:group_id])
    membership = Membership.find_by(member_id: current_member.id, group_id: group.id)
    if membership
      membership.update(is_active: true)
    else
      membership = Membership.create!(group_id: group.id, member_id: current_member.id)
    end
    redirect_to group_my_membership_path(group.id, current_member.id)
  end
  
  def show
    @group = Group.find(params[:group_id])
    @member = Member.find(params[:member_id])
    @membership = Membership.where(group_id: @group.id, member_id: @member.id).first
  end

  def withdraw
    group = Group.find(params[:group_id])
    membership = Membership.find(params[:id])
    if membership.update!(is_active: false)
      flash[:notice] = 'グループから退会しました'
      if group.owner_id == current_member.id
        group.change_owner
      end
    end
    redirect_to mypage_path
  end
  
end
