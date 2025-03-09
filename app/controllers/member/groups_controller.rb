class Member::GroupsController < ApplicationController
  before_action :authenticate_member!
  before_action :owner?, only: [:update, :edit, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_member.id
    if @group.save
      membership = Membership.create!(group_id: @group.id, member_id: current_member.id)
      flash[:notice] = 'グループを作成しました！'
      redirect_to group_membership_path(@group.id, membership.id)
    else
      flash.now[:alert] = 'グループの作成に失敗しました'
      render :new
    end
  end
  

  def show
    @group = Group.find(params[:id])
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group.id)
      flash[:notice] = 'グループを編集しました！'
    else
      flash.now[:notice] = 'グループの作成に失敗しました'
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:notice] = 'グループを削除しました'
    redirect_to mypage_path
  end
  
  def search
    word = params[:word].to_s.strip # to_s は空文字が送られてきた時用
    if word.present? # wordが存在、空じゃないか
      @search_groups = Group.where('name LIKE ?', "%#{word}%").page(params[:page])
    else
      @search_groups = Group.none
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image, :category_id)
  end

  def owner?
    @group = Group.find(params[:id])
    unless @group.owner_id == current_member.id
      redirect_to group_path(@group.id)
    end
  end

end
