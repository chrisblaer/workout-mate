CREATE DATABASE workout_mate;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(50),
  email VARCHAR(400),
  password_digest VARCHAR(400)
);

CREATE TABLE exercises(
  id SERIAL PRIMARY KEY,
  title VARCHAR(200),
  description TEXT,
  image_url VARCHAR(200)
);

CREATE TABLE workouts(
  id SERIAL PRIMARY KEY,
  title VARCHAR(200),
  description TEXT,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE exercises_workouts(
  id SERIAL PRIMARY KEY,
  workout_id INTEGER,
  exercise_id INTEGER,
  FOREIGN KEY (workout_id) REFERENCES workouts (id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises (id) ON DELETE RESTRICT
);

-- dummy data; psql --
u1 = User.new
  u1.username = 'chris'
  u1.email = 'c@b.com'
  u1.password = 'pudding'
u1.save
-----------------------
-----------------------
u2 = User.new
  u2.username = 'rich'
  u2.email = 'r@h.com'
  u2.password = 'pudding'
u2.save
-----------------------
-----------------------
w1 = Workout.new
  w1.title = 'upper body'
  w1.description = 'great workout'
  w1.user_id = 2
w1.save
-----------------------
-----------------------
e1 = Exercise.new
  e1.title = 'lat pulls'
  e1.description = 'great for your back'
e1.save
-----------------------
-----------------------
ew1 = ExercisesWorkout.new
  ew1.workout_id = 1
  ew1.exercise_id = 1
ew1.save