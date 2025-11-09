class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_recipes, through: :likes, source: :recipe
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower


  validates :name, presence: true, length: {maximum: 20}
  validates :profile, length: {maximum: 200}

  def active_for_authentication?
    super && status != 'inactive'
  end

  def inactive_message
    status == 'inactive' ? :account_inactive : super
  end

  def follow(user)
    followings << user unless self == user
  end

  def unfollow(user)
    followings.delete(user)
  end

  def following?(user)
    followings.include?(user)
  end
  
end
