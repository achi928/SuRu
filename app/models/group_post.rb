class GroupPost < ApplicationRecord
  belongs_to :member
  belongs_to :group
  has_many :likes, dependent: :destroy
  has_many :group_posts, dependent: :destroy
  has_one_attached :post_image
end
