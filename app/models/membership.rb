class Membership < ApplicationRecord
  belongs_to :member
  belongs_to :group

# is_active: true のメンバーシップだけを取得する
# Membership.active を実行すると、is_active: trueのレコードだけを取得するSQLが実行される
  scope :active, -> { where(is_active: true) }

end