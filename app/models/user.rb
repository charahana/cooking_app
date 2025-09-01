class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :profile_image
  has_many :recipes, dependent: :destroy

  validates :name, presence: true, length: {maximum: 20}
  validates :profile, length: {maximum: 200}

  def active_for_authentication?
    super && status != 'inactive'
  end

  def inactive_message
    status == 'inactive' ? :account_inactive : super
  end
  
end
