class Category < ApplicationRecord
  has_many :groups, dependent: :destroy

  has_one_attached :category_image

  validates :name, presence: true

  def get_category_image(weight,height)
    unless category_image.attached?
      file_path = Rails.root.join('app/assets/images/top.png')
      category_image.attach(io: File.open(file_path), filename: 'default-image.jpeg')
    end
    category_image.variant(resize_to_limit: [weight,height]).processed
  end
end
