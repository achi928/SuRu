class Member < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_posts, dependent: :destroy

  has_one_attached :profile_image

  enum gender: { Unspecified: 0, Female: 1, Male: 2 }

end
