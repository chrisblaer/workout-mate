require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'workout_mate'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)