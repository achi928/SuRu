class Member::MembershipsController < ApplicationController
  before_action :authenticate_member!
  before_action :active_membership?, only: [:withdraw]

  def create
    group = Group.find(params[:group_id])
    membership = Membership.find_by(member_id: current_member.id, group_id: group.id)
  
    if membership
      if membership.update(is_active: true)
        flash[:notice] = '再入会しました！'
        redirect_to group_path(group.id)
      else
        flash[:alert] = '再入会に失敗しました'
        redirect_to information_path(group.id)
      end
  
    elsif membership.nil?
      new_membership = Membership.new(group_id: group.id, member_id: current_member.id)
  
      if new_membership.save
        flash[:notice] = '入会しました！'
        redirect_to group_path(group.id)
      else
        flash[:alert] = '入会に失敗しました'
        redirect_to information_path(group.id)
      end
    end
  
    
  end
  

  def withdraw
    membership = Membership.find(params[:id])
    if membership.update(is_active: false)
      flash[:notice] = 'グループから退会しました'
      if @group.owner_id == current_member.id
        @group.change_owner
      end
    else
      flash[:alert] = 'グループから退会に失敗しました'
    end
    redirect_to mypage_path
  end

  private

  def active_membership?
    @group = Group.find(params[:group_id])
    unless @group.memberships.active.exists?(member_id: current_member.id)
      redirect_to mypage_path
    end
  end

end
