import 'package:flutter/foundation.dart';

class WorkoutStep {
  final String number;
  final String title;
  final String description;

  WorkoutStep({required this.number, required this.title, required this.description});
}

class WorkoutDetailProvider with ChangeNotifier {
  String _workoutName = 'Jumping Jack';
  String _difficulty = 'Easy';
  int _caloriesBurn = 200;
  int _selectedReps = 30;  // Default value for repetitions
  String _description = 'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, is a physical jumping exercise performed by jumping to a position with the legs spread wide...';
  List<WorkoutStep> _steps = [
    WorkoutStep(number: '01', title: 'Spread Your Arms', description: 'To make the exercise feel more relaxed, spread your arms out to the sides in this movement. No bending of hands.'),
    WorkoutStep(number: '02', title: 'Rest at The Top', description: 'The basic of this movement is jumping, how what needs to be considered is that you need to rest at the top of your feet'),
    WorkoutStep(number: '03', title: 'Adjust Foot Movement', description: 'Jumping Jack is not just an ordinary jump, but you also have to pay close attention to leg movements.'),
    WorkoutStep(number: '04', title: 'Clapping Both Hands', description: 'This exercise feels more exciting, You see, without realizing it, the clapping of your hands also includes arm muscle movement'),
  ];

  String get workoutName => _workoutName;
  String get difficulty => _difficulty;
  int get caloriesBurn => _caloriesBurn;
  int get selectedReps => _selectedReps;  // Getter for repetitions
  String get description => _description;
  List<WorkoutStep> get steps => _steps;

  // Method to update workout details
  void updateWorkoutDetails({
    String? workoutName,
    String? difficulty,
    int? caloriesBurn,
    int? selectedReps,  // Accept repetitions
    String? description,
    List<WorkoutStep>? steps,
  }) {
    if (workoutName != null) _workoutName = workoutName;
    if (difficulty != null) _difficulty = difficulty;
    if (caloriesBurn != null) _caloriesBurn = caloriesBurn;
    if (selectedReps != null) _selectedReps = selectedReps;  // Update selected reps
    if (description != null) _description = description;
    if (steps != null) _steps = steps;
    notifyListeners();
  }

  // Method to set repetitions and calories
  void setRepetitions(int reps, int calories) {
    _selectedReps = reps;
    _caloriesBurn = calories;
    notifyListeners();
  }
}
