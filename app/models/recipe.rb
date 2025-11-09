class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true, length: { maximum: 100 }, if: :published?
  validates :body, presence: true, if: :published?

  attr_accessor :tag_names

  after_save :save_tags

  private

  scope :visible_for, ->(user) {
    if user
      where(status: :published).or(where(status: :draft, user_id: user.id))
    else
      where(status: :published)
    end
  }

  def save_tags
    return if tag_names.blank?
    tag_list = tag_names.split(',').map(&:strip).uniq
    self.tags = tag_list.map do |name|
      Tag.find_or_create_by(name: name)
    end
  end
end
