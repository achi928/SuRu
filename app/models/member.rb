class Member < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :memberships
  has_many :groups, through: :memberships
  has_many :likes
  has_many :comments
  has_many :posts
  # オーナーが自分のグループを集める
  has_many :owner_groups, class_name: 'Group', foreign_key: :owner_id

  has_one_attached :profile_image

  enum gender: { unspecified: 0, female: 1, male: 2 }

  validates :nickname, presence: true, length: { in: 1..20 }
  validates :password, format: { with: /\A\d{6}\z/, message: 'パスワードは6桁の数字で入力してください' }, on: :create

  def active_for_authentication?
    super && (is_active == true)
  end
  
  def get_profile_image(weight,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.png')
    end
    # variantはmember modelのupdateがかかる
      profile_image.variant(resize_to_limit: [weight,height]).processed
  end
  
  def age_group
    # 未設定はnilを返す
    return nil unless birth_year

    year = birth_year.to_i
    age = Date.today.year - year
  
    case age
    when 10..19
      "10's"
    when 20..29
      "20's"
    when 30..39
      "30's"
    when 40..49
      "40's"
    when 50..59
      "50's"
    else
      "Over 60's"
    end
  end
  
  def change_group_owner
    owner_groups.each do |group|
      group.change_owner
    end
  end

  def gender_option
    genders = []
    Member.genders_i18n.each do |key, value|
      genders << [key,value]
    end
  end

end
