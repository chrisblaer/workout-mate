require 'pry'
require 'sinatra'
#require 'sinatra/reloader' # comment out before deployment to heroku

require_relative 'db_config'
require_relative 'models/exercise'
require_relative 'models/exercises_workout'
require_relative 'models/log'
require_relative 'models/user'
require_relative 'models/workout'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def exercise_list
    Exercise.all
  end

  def exercises_workout_list
    ExercisesWorkout.all
  end

  def workout_log

  end
end

get '/' do
  erb :index
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    session[:username] = user.username
    session[:email] = user.email
    redirect to('/profile')
  else
    redirect to('/')
  end
end

delete '/session' do
  session[:user_id] = nil
  redirect to('/')
end

get '/signup' do
  erb :signup
end

post '/users' do
  user = User.new
  user.username = params[:username]
  user.email = params[:email]
  user.password = params[:password]
  user.save

  session[:user_id] = user.id
  session[:username] = user.username
  session[:email] = user.email
  
  redirect to('/profile')
end

get '/users/delete' do
  redirect to('/') unless logged_in?
  erb :delete
end

delete '/users/:id' do
  user = User.find_by(id: params[:id])
  user.destroy
  session[:user_id] = nil # need to do this, because current_user helper function checks for it, but do I need to do the next 2 lines?
  session[:username] = nil # this?
  session[:email] = nil # this?

  redirect to('/')
end

get '/profile' do
  erb :profile
end

get '/workouts/new' do
  erb :new
end

get '/workouts' do
  erb :workout
end

post '/workouts' do
  redirect to('/') unless logged_in?
  
  workout = Workout.new
  workout.title = params[:workout_title]
  workout.description = params[:workout_description]
  workout.user_id = session[:user_id]
  workout.save

  params['exercises'].each do |key, exercise_id|
    exercises_workout_rel = ExercisesWorkout.new
    exercises_workout_rel.workout_id = workout.id
    exercises_workout_rel.exercise_id = exercise_id
    exercises_workout_rel.save
  end

  redirect to('/workouts')
end

delete '/workouts/:id' do
  redirect to('/') unless logged_in?
  
  workout = Workout.find_by(id: params[:id])
  workout.destroy
  
  redirect to('/workouts')
end

get '/workouts/:id/edit' do
  @workout = Workout.find_by(id: params[:id])

  @exercises_workout_rel = ExercisesWorkout.select{ |rel| rel.workout_id == params[:id].to_i}
  erb :edit
end

put '/workouts/:id' do
  redirect to('/') unless logged_in?

  workout = Workout.find_by(id: params[:id])
  workout.title = params[:workout_title]
  workout.description = params[:workout_description]
  workout.save

  redirect to('/workouts')
end

get '/workouts/:id/log' do
  @workout = Workout.find_by(id: params[:id])
  @exercises_workout_rel = ExercisesWorkout.select{ |rel| rel.workout_id == params[:id].to_i}
  erb :log
end

post '/workouts/log' do
  redirect to('/') unless logged_in?
  params['exercises_workout_ids'].each do |key, relationship_id|
    log = Log.new
    log.exercises_workout_id = params['exercises_workout_ids'][key]
    log.set_no = params['sets'][key]
    log.weight = params['weights'][key]
    log.reps = params['reps'][key]
    log.created_date = params['created_date']
    log.save
  end

  redirect to('/workouts')
end