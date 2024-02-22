import 'dart:io';
//import 'main.dart';
import 'exercise.dart';
import 'project.dart';
import 'workout.dart';

String userDataFilePath = 'user_data.txt';
List<User> users = [];
class FitnessApp {
  List<Workout> availableWorkouts = [];
  List<User> users = [];
  String userDataFilePath = 'user_data.txt';
  FitnessApp() {
    loadUserData();
  }
  //user ka data wala kam file mai
  //user data ka funct...
void loadUserData() {
  try {
    File file = File(userDataFilePath);
    if (file.existsSync()) {
      List<String> lines = file.readAsLinesSync();
      for (var line in lines) {
        var data = line.split(',');
        var user = User(data[0]);
        user.totalPoints = int.parse(data[1]);
        users.add(user);
      }
    }
  } catch (e) {
    print("Error loading user data: $e");
  }
}

void saveUserData() {
  try {
    File file = File(userDataFilePath);
    var lines =
        users.map((user) => '${user.name},${user.totalPoints}').toList();
    file.writeAsStringSync(lines.join('\n'));
  } catch (e) {
    print("Error saving user data: $e");
  }
}

void addUser(String name) {
  users.add(User(name));
  saveUserData();
}

void addWorkout(String name, List<Exercise> exercises) {
  availableWorkouts.add(Workout(name, exercises));
}

void displayWorkouts() {
  print("Available Workouts:");
  for (var workout in availableWorkouts) {
    print("${workout.name} - ${workout.exercises.length} exercises");
  }
}

void startWorkout(User user, Workout workout) {
  print("Starting ${workout.name} workout for ${user.name}...");
  user.completedWorkouts.add(workout);
  user.totalPoints += calculatePoints(workout);
  saveUserData();
  print("Workout completed! Good job, ${user.name}!");
  print("Total Points: ${user.totalPoints}");
}

int calculatePoints(Workout workout) {
  return workout.exercises.length * 10; // Points for each exercise
}

void suggestWorkout(User user) {
  if (availableWorkouts.isEmpty) {
    print("No workouts available. Add some workouts first.");
    return;
  }

  print("Suggested Workout for ${user.name}:");
  var suggestedWorkout = availableWorkouts[0];
  displayWorkoutDetails(suggestedWorkout);
  startWorkout(user, suggestedWorkout);
}

void displayWorkoutDetails(Workout workout) {
  print("Workout: ${workout.name}");
  for (var exercise in workout.exercises) {
    print("  - ${exercise.name}: ${exercise.description}");
  }
}


}
