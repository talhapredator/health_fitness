import 'package:flutter/foundation.dart';

class Exercise {
  final String name;
  final String imageUrl;
  final String duration;

  Exercise({required this.name, required this.imageUrl, required this.duration});
}

class WorkoutProvider with ChangeNotifier {
  String _workoutName = 'Fullbody Workout';
  int _calories = 320;
  Duration _duration = Duration(minutes: 30);
  DateTime _scheduleTime = DateTime.now().add(Duration(days: 1));
  String _difficulty = 'Beginner';
  List<String> _equipment = ['Barbell', 'Skipping rope', 'Bottle 1L'];
  List<Exercise> _exercises = [
    Exercise(name: 'Warm Up', imageUrl: 'https://img.lovepik.com/free-png/20220108/lovepik-blue-girl-skipping-rope-png-image_401302489_wh860.png', duration: '10:00'),
    Exercise(name: 'Jumping Jack', imageUrl: 'https://img.freepik.com/premium-vector/jumping-jacks-exercise-woman-workout-fitness-aerobic-exercises_476141-1514.jpg', duration: '5:00'),
    Exercise(name: 'Skipping', imageUrl: 'https://img.lovepik.com/free-png/20220108/lovepik-blue-girl-skipping-rope-png-image_401302489_wh860.png', duration: '5:00'),
  ];

  String get workoutName => _workoutName;
  int get calories => _calories;
  Duration get duration => _duration;
  DateTime get scheduleTime => _scheduleTime;
  String get difficulty => _difficulty;
  List<String> get equipment => _equipment;
  List<Exercise> get exercises => _exercises;

  void updateWorkout({
    String? workoutName,
    int? calories,
    Duration? duration,
    DateTime? scheduleTime,
    String? difficulty,
    List<String>? equipment,
    List<Exercise>? exercises,
  }) {
    if (workoutName != null) _workoutName = workoutName;
    if (calories != null) _calories = calories;
    if (duration != null) _duration = duration;
    if (scheduleTime != null) _scheduleTime = scheduleTime;
    if (difficulty != null) _difficulty = difficulty;
    if (equipment != null) _equipment = equipment;
    if (exercises != null) _exercises = exercises;
    notifyListeners();
  }

  void scheduleWorkout(DateTime newTime) {
    _scheduleTime = newTime;
    notifyListeners();
  }
}
