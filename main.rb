require 'pry'
require 'sinatra'
require 'sinatra/reloader'

require_relative 'db_config'
require_relative 'models/exercise'
require_relative 'models/exercises_workout'
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

delete '/users' do
  user = User.find_by(id: session[:user_id])
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
  workout.title = params[:title]
  workout.description = params[:description]
  workout.user_id = session[:user_id]
  workout.save
  
  redirect to('/workouts')
end

delete '/workouts' do
  redirect to('/') unless logged_in?
  
  workout = Workout.find_by(id: params[:workout_id])
  workout.destroy
  
  redirect to('/workouts')
end

get '/workouts/:id/edit' do
  @workout = Workout.find_by(id: params[:id])
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