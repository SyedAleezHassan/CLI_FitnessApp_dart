import 'dart:io';

import 'exercise.dart';
import 'functions.dart';
import 'workout.dart';


//exercidse



class User {
  String name;
  List<Workout> completedWorkouts = [];
  int totalPoints = 0;
  User(this.name);
}



void main() {
  var fitnessApp = FitnessApp();

  // Add some exercises
  var pushUp = Exercise("Push-up", "Upper Body",
      "Place hands shoulder-width apart and lower body to the ground.");
  var squat = Exercise("Squat", "Lower Body",
      "Stand with feet shoulder-width apart and lower hips toward the ground.");
  var plank = Exercise("Plank", "Core",
      "Maintain a straight line from head to heels in a plank position.");

  // Add some workouts
  fitnessApp.addWorkout("Full Body Workout", [pushUp, squat, plank]);
  fitnessApp.addWorkout("Cardio Blast", [squat, plank]);
  fitnessApp.addWorkout("Core Strengthening", [plank]);

  while (true) {
    print("\nFitness Coaching Application");
    print("1. Register User");
    print("2. Display Available Workouts");
    print("3. Start Workout");
    print("4. Suggest Workout");
    print("5. Quit");

    var choice = int.tryParse(stdin.readLineSync()!) ?? 0;

    switch (choice) {
      case 1:
        print("Enter user name: ");
        var userName = stdin.readLineSync()!;
        fitnessApp.addUser(userName);
        print("User $userName registered successfully!");
        break;
      case 2:
        fitnessApp.displayWorkouts();
        break;
      case 3:
        print("Enter user name: ");
        var userName = stdin.readLineSync()!;
        var user = fitnessApp.users.firstWhere(
          (u) => u.name == userName,
          orElse: () => User("Guest"),
        );
        if (user != null) {
          print("Select a workout to start:");
          fitnessApp.displayWorkouts();
          print("Enter workout name: ");
          var workoutName = stdin.readLineSync()!;
          var workout = fitnessApp.availableWorkouts.firstWhere(
            (w) => w.name == workoutName,
            orElse: () => Workout("Unknown Workout", []),
          );
          if (workout != null) {
            fitnessApp.startWorkout(user, workout);
          } else {
            print("Workout not found.");
          }
        } else {
          print("User not found.");
        }
        break;
      case 4:
        print("Enter user name: ");
        var userName = stdin.readLineSync()!;
        var user = fitnessApp.users.firstWhere(
          (u) => u.name == userName,
          orElse: () => User("Guest"),
        );
        if (user != null) {
          fitnessApp.suggestWorkout(user);
        } else {
          print("User not found.");
        }
        break;
      case 5:
        print("Goodbye!");
        return;
      default:
        print("Invalid choice. Try again.");
        break;
    }
  }
}
