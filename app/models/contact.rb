class Contact < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true
  validates :message, presence: true

  enum subject: {
    account: 0,
    team: 1,
    error: 2,
    trouble: 3,
    others: 4
  }
  
end