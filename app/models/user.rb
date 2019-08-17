class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable
  has_many :exercises

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  self.per_page = 15

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
