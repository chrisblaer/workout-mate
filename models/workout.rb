class Workout < ActiveRecord::Base
  belongs_to :user
  has_many :exercises_workouts
end