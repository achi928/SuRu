class Group < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'Member'
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships
  has_many :group_posts, dependent: :destroy
  
  has_one_attached :group_image
end
