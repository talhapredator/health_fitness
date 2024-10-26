import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_tracker_app/providers/alarm_provider.dart';

class AddAlarmScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/schedule'),
        ),
        title: Text('Add Alarm'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {}, // Add functionality here
          ),
        ],
      ),
      body: Consumer<AlarmProvider>(
        builder: (context, alarmProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildListTile('Bedtime', '08:00 PM', Icons.bedtime, onTap: () {
                  // Implement bedtime picker
                }),
                _buildListTile('Hours of sleep', '8hours 30minutes', Icons.access_time, onTap: () {
                  // Implement sleep duration picker
                }),
                _buildListTile('Repeat', 'Mon to Fri', Icons.repeat, onTap: () {
                  // Implement repeat options
                }),
                SwitchListTile(
                  title: Text('Vibrate When Alarm Sound'),
                  value: alarmProvider.vibrateWhenAlarmSound,
                  onChanged: (value) => alarmProvider.setVibrateWhenAlarmSound(value),
                ),
                Spacer(),
                ElevatedButton(
                  child: Text('Add'),
                  onPressed: () {
                    // Implement add alarm functionality
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}