import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart'; // Add Provider package
import 'package:health_tracker_app/providers/auth_provider.dart'; // Import your AuthProvider

class UpcomingWorkoutsWidget extends StatelessWidget {
  const UpcomingWorkoutsWidget({Key? key}) : super(key: key);

  // Method to toggle notification by making a request to the backend
  Future<void> toggleNotification(String workoutName, String time, bool isEnabled, String? token) async {
    try {
      final url = Uri.parse('https://localhost:5000/api/toggle-notification');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',  // Pass the user's token here
        },
        body: json.encode({
          'workoutName': workoutName,  // Workout name such as 'Fullbody Workout'
          'time': time,  // Pass the time associated with the workout
          'isEnabled': isEnabled,  // true or false based on the switch
        }),
      );

      if (response.statusCode == 200) {
        print('Notification updated successfully for $workoutName');
      } else {
        print('Failed to update notification for $workoutName: ${response.body}');
      }
    } catch (e) {
      print('Error while toggling notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context); // Get AuthProvider

    // A mock list of upcoming workouts (you can modify this with your real data)
    final List<Map<String, String>> workouts = [
      {'title': 'Full Body Exercise', 'time': 'Today, 03:00 PM'},
      {'title': 'Lower Body Workout', 'time': 'Tomorrow, 11:00 AM'},
      // Add more workouts dynamically
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            spreadRadius: 2, // Spread radius of the shadow
            blurRadius: 8, // Blur radius of the shadow
            offset: const Offset(0, 2), // Offset of the shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upcoming Workouts', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...workouts.map((workout) {
            return _buildWorkoutItem(
              workout['title']!,
              workout['time']!,
              false, // This can be fetched from the backend if needed
              authProvider.token,
            );
          }).toList(),
        ],
      ),
    );
  }

  // This method builds each workout item row with the toggle switch
  Widget _buildWorkoutItem(String title, String time, bool isEnabled, String? token) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(time),
      trailing: Switch(
        value: isEnabled,
        onChanged: (bool value) async {
          await toggleNotification(title, time, value, token);  // Pass time as well
          print('$title notification toggled: $value');
        },
      ),
    );
  }
}
