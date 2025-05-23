class Post < ApplicationRecord
  belongs_to :member
  belongs_to :group
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :post_image

  validates :content, presence: true

  def get_post_image(weight,height)
    if post_image.attached?
      post_image.variant(resize_to_limit: [weight, height]).processed
    else
      nil
    end
  end

end
