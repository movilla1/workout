class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User", primary_key: "id", foreign_key: "friend_id"
end
