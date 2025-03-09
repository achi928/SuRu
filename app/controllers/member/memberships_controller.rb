class Member::MembershipsController < ApplicationController
  before_action :authenticate_member!

  def create
    group = Group.find(params[:group_id])
    membership = Membership.create!(group_id: group.id, member_id: current_member.id)
    redirect_to group_membership_path(group.id, membership.id)
  end
  

  def show
  end

  def destroy
  end

end
