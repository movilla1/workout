class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable
  has_many :exercises
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  self.per_page = 15

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def follows_or_same?(new_friend)
    friendships.map(&:friend).include?(new_friend) || self == new_friend
  end

  def current_friendship(friend)
    friendships.where(friend: friend).try(:first)
  end
end
