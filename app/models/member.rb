class Member < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :groups, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :group_posts, dependent: :destroy

  has_one_attached :profile_image

  enum gender: { unspecified: 0, female: 1, male: 2 }

  validates :nickname, presence: true, length: { in: 1..20 }

  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_limit: [width, height]).processed
    else
      ActionController::Base.helpers.asset_path('default.png')
    end
  end
  
  def age_group
    return nil if birth_year.nil?
  
    age = Date.today.year - birth_year
  
    case age
    when 0..9
      "10歳未満"
    when 10..19
      "10代"
    when 20..29
      "20代"
    when 30..39
      "30代"
    when 40..49
      "40代"
    when 50..59
      "50代"
    else
      "60代以上"
    end
  end  

end
