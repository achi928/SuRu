class Member < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  # オーナーが自分のグループを集める
  has_many :owner_groups, class_name: 'Group', foreign_key: :owner_id

  has_one_attached :profile_image

  enum gender: { unspecified: 0, female: 1, male: 2 }

  validates :nickname, presence: true, length: { in: 1..20 }

  def active_for_authentication?
    super && (is_active == true)
  end
  
  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.png')
    end
      profile_image.variant(resize_to_limit: [300, 200]).processed
  end
  
  def age_group
    # 未設定はnilを返す
    return nil unless birth_year
  
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
  
  def change_group_owner
    owner_groups.each do |group|
      group.change_owner
    end
  end

end
