class GroupPost < ApplicationRecord
  belongs_to :member
  belongs_to :group
  has_many :likes, dependent: :destroy
  has_one_attached :post_image

  validates :content, presence: true

  def get_post_image
    return unless post_image.attached?
    post_image.variant(resize_to_limit: [300, 200]).processed
  end
  
end
