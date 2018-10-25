CREATE DATABASE workout_mate;

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) UNIQUE,
  email VARCHAR(400) UNIQUE,
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

CREATE TABLE logs(
  id SERIAL PRIMARY KEY,
  exercises_workout_id INTEGER,
  set_no INTEGER,
  weight REAL,
  reps INTEGER,
  created_date TIMESTAMPTZ,
  FOREIGN KEY (exercises_workout_id) REFERENCES exercises_workouts (id) ON DELETE CASCADE
);

-- exercises seed:
INSERT INTO exercises(title, description, image_url) VALUES('Leg Press', 'lorem ipsum', 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_650/MTQ1MzY2OTYwMzI1MDc2NTM1/leg-press-calf-raise.webp');


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
-----------------------
-----------------------
-----------------------
INSERT INTO exercises(title, description, image_url) VALUES
  ('Front Squat', 'lorem ipsum', 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_576/MTQ1MzY2OTYwMzIzOTYyNDIz/frontsquat-b.webp'),
  ('Romanian Deadlift', 'lorem ipsum', 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_650/MTQ1MzY2OTYwMzI0NjgzMzE5/romanian_deadliftb.webp'),
  ('Bulgarian Split Squat', 'lorem ipsum', 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_650/MTQ1MzY2OTYwMzIzMTEwNDU1/bulgarian-split-squat_052.webp')
  ;
-----------------------
-----------------------
-----------------------


e2 = Exercise.new
  e2.title = 'Leg Press'
  e2.description = 'lorem ipsum'
  e2.image_url = 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_650/MTQ1MzY2OTYwMzI1MDc2NTM1/leg-press-calf-raise.webp'
e2.save
---
e3 = Exercise.new
  e3.title = 'Barbell Squat'
  e3.description = 'lorem ipsum'
  e3.image_url = 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_650/MTQ1MzY2OTYwMzI1NDY5NzUx/e90a6321.webp'
e3.save

e4 = Exercise.new
  e4.title = 'Front Squat'
  e4.description = 'lorem ipsum'
  e4.image_url = 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_576/MTQ1MzY2OTYwMzIzOTYyNDIz/frontsquat-b.webp'
e4.save

e5 = Exercise.new
  e5.title = 'Romanian Deadlift'
  e5.description = 'lorem ipsum'
  e5.image_url = 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_650/MTQ1MzY2OTYwMzI0NjgzMzE5/romanian_deadliftb.webp'
e5.save

e6 = Exercise.new
  e6.title = 'Bulgarian Split Squat'
  e6.description = 'lorem ipsum'
  e6.image_url = 'https://www.muscleandperformance.com/.image/c_limit%2Ccs_srgb%2Cq_auto:good%2Cw_650/MTQ1MzY2OTYwMzIzMTEwNDU1/bulgarian-split-squat_052.webp'
e6.save