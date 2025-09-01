class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
end
