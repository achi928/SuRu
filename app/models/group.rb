class Group < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'Member'
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships
  has_many :group_posts, dependent: :destroy
  
  has_one_attached :group_image

  def get_group_image
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/group.png')
      group_image.attach(io: File.open(file_path), filename: 'default-image.png')
    end
      group_image.variant(resize_to_limit: [300, 200]).processed
  end
end
