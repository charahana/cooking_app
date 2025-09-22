class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  enum status: { active: 0, inactive: 1 }
  validates :body, presence: true
end
