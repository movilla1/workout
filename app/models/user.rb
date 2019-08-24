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

  def follows_or_same?(new_friend_id)
    friendships.map(&:friend_id).include?(new_friend_id) || self.id == new_friend_id
  end

  def current_friendship(friend_id)
    friendships.where(friend_id: friend_id).try(:first)
  end
end
