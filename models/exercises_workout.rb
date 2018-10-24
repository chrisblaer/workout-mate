class ExercisesWorkout < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout
  has_many :logs
end