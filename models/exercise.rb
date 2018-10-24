class Exercise < ActiveRecord::Base
  has_many :exercises_workouts
  has_many :workouts, through: :exercises_workouts
  has_many :users, through: :workouts
  has_many :logs, through: :exercises_workouts
end