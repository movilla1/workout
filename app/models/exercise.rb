class Exercise < ApplicationRecord
  belongs_to :user
  validates :workout, length: { minimum: 5}
  validates :duration_in_minutes, numericality: {
    only_integer: true, greater_than: 0
  }
end
