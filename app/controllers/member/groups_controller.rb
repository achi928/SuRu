class Member::GroupsController < ApplicationController
  before_action :authenticate_member!
  before_action :owner?, only: [:update, :edit, :destroy]
  before_action :active_membership?, only: [:show]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_member.id
    if @group.save
      membership = Membership.create!(group_id: @group.id, member_id: current_member.id)
      flash[:notice] = 'グループを作成しました！'
      redirect_to group_path(@group.id)
    else
      flash.now[:alert] = 'グループの作成に失敗しました'
      render :new
    end
  end

  def show
    @membership = Membership.find_by(group_id: @group.id, member_id: current_member.id)
    @post = Post.new
    @posts = @group.posts

  def information
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = 'グループを編集しました！'
      redirect_to information_path(@group.id)
      
    else
      flash.now[:alert] = 'グループの編集に失敗しました'
      render :edit
    end
  end

  def destroy
    if @group.destroy
      flash[:notice] = 'グループを削除しました'
      redirect_to mypage_path
    else
      flash[:alert] = 'グループの削除に失敗しました'
      redirect_to information_path(@group.id)
    end
  end
  
  
  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :category_id)
  end

  def owner?
    @group = Group.find(params[:id])
    unless @group.owner_id == current_member.id
      redirect_to information_path(@group.id)
    end
  end

  def active_membership?
    @group = Group.find(params[:id])
    unless @group.memberships.active.exists?(member_id: current_member.id)
      redirect_to mypage_path
    end
  end

end
