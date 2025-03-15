class Group < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'Member'
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships
  has_many :posts, dependent: :destroy
  
  has_one_attached :group_image

  validates :name, presence: true
  validates :introduction, presence: true

  def get_group_image
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/group.png')
      group_image.attach(io: File.open(file_path), filename: 'default-image.png')
    end
      group_image.variant(resize_to_limit: [300, 200]).processed
  end

  def change_owner
    # where.not(member_id: self.owner_id)で、今回退会する人(current_member)を省いたメンバーIDを取得する
    # order(:id)で古い人が先に並べ替え、SQLだと、ORDER BY id ASC
    active_members = self.memberships.active.where.not(member_id: self.owner_id).order(:id)
    # 一番古くからいるメンバーを新しいオーナーにする
    new_owner = active_members.first
    if new_owner
      self.update(owner_id: new_owner.member_id)
    else
      self.destroy
    end
  end

end


