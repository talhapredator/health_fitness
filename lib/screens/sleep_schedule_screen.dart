import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:health_tracker_app/providers/sleep_schedule_provider.dart';  // Your provider import

class SleepScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            _buildIdealHoursSection(),
            SizedBox(height: 20),
            _buildScheduleSection(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/alarm');
        },
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // Custom AppBar with back and more button
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/sleep');
            },
          ),
          Text(
            'Sleep Schedule',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {
              // Add more action here
            },
          ),
        ],
      ),
    );
  }

  // Ideal hours for sleep section with the "Learn More" button and image
  Widget _buildIdealHoursSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.purple[100],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ideal Hours for Sleep', style: TextStyle(color: Colors.blueGrey, fontSize: 16)),
                Text('8hours 30minutes', style: TextStyle(color: Colors.blueAccent, fontSize: 20)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add Learn More action
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                  child: Text('Learn More'),
                ),
              ],
            ),
            Image.asset('assets/images/schedule-1.jpg', height: 80), // Example image asset
          ],
        ),
      ),
    );
  }

  // Main schedule section with the date picker and the bedtime/alarm widgets
  Widget _buildScheduleSection(BuildContext context) {
    final sleepSchedule = Provider.of<SleepScheduleProvider>(context);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('Your Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10),
          _buildDatePicker(context),
          SizedBox(height: 50),
          _buildBedtimeCard(sleepSchedule),
          SizedBox(height: 20),
          _buildAlarmCard(sleepSchedule),
          Spacer(),

        ],
      ),
    );
  }

  // Date picker (horizontally scrollable)
  Widget _buildDatePicker(BuildContext context) {
    final sleepSchedule = Provider.of<SleepScheduleProvider>(context);

    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sleepSchedule.weekDates.length,
        itemBuilder: (context, index) {
          final date = sleepSchedule.weekDates[index];
          final isSelected = sleepSchedule.selectedDate == date;

          return GestureDetector(
            onTap: () => sleepSchedule.updateSelectedDate(date),
            child: Container(
              width: 60,
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.purpleAccent : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${date.day}',
                    style: TextStyle(
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    _getWeekdayString(date),
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Get weekday string
  String _getWeekdayString(DateTime date) {
    const weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return weekdays[date.weekday - 1];
  }

  // Bedtime card with icon, time, countdown and toggle switch
  Widget _buildBedtimeCard(SleepScheduleProvider sleepSchedule) {
    return _buildScheduleCard(
      icon: Icons.bedtime_rounded,
      title: 'Bedtime',
      time: sleepSchedule.bedtime,
      durationText: 'in ${sleepSchedule.timeUntilBed.inHours}hours ${sleepSchedule.timeUntilBed.inMinutes % 60}minutes',
      toggleValue: true,
    );
  }

  // Alarm card with icon, time, countdown and toggle switch
  Widget _buildAlarmCard(SleepScheduleProvider sleepSchedule) {
    return _buildScheduleCard(
      icon: Icons.alarm,
      title: 'Alarm',
      time: sleepSchedule.alarmTime,
      durationText: 'in ${sleepSchedule.timeUntilAlarm.inHours}hours ${sleepSchedule.timeUntilAlarm.inMinutes % 60}minutes',
      toggleValue: false,
    );
  }

  // Helper method for creating Bedtime/Alarm card
  Widget _buildScheduleCard({
    required IconData icon,
    required String title,
    required String time,
    required String durationText,
    required bool toggleValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Colors.purple),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(time, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                    Text(durationText, style: TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
              ],
            ),
            Switch(
              value: toggleValue,
              onChanged: (value) {
                // Handle toggle switch change
              },
              activeColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  // Bottom progress bar for sleep tracking
  Widget _buildProgressBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('You will get 8hours 10minutes for tonight'),
          SizedBox(height: 20),
          LinearProgressIndicator(
            value: 0.96,
            backgroundColor: Colors.grey[300],
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
