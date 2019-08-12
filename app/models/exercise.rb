class Exercise < ApplicationRecord
  belongs_to :user
  validates :workout, length: { minimum: 5}
  validates :duration_in_minutes, numericality: {
    only_integer: true, greater_than: 0
  }
  validates :workout_date, presence: true

  default_scope {
    where('workout_date > ?', 7.days.ago).order(workout_date: :desc)
  }
end
