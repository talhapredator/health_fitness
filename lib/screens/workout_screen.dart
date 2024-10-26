import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_tracker_app/widgets/upcoming_workout_widget.dart'; // Import your widget here

class WorkoutData {
  final String day;
  final double percentage;

  WorkoutData(this.day, this.percentage);
}

class WorkoutTrackerScreen extends StatelessWidget {
  final List<WorkoutData> workoutData = [
    WorkoutData('Sun', 60),
    WorkoutData('Mon', 40),
    WorkoutData('Tue', 95),
    WorkoutData('Wed', 60),
    WorkoutData('Thu', 30),
    WorkoutData('Fri', 78),
    WorkoutData('Sat', 50),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pushReplacementNamed(context, '/dashboard'),
              ),
              title: const Text(
                'Workout Tracker',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildChart(),
                    const SizedBox(height: 20),
                    _buildDailyWorkoutSchedule(context),
                    const SizedBox(height: 20),
                    const UpcomingWorkoutsWidget(), // Integrating UpcomingWorkoutsWidget here
                    const SizedBox(height: 20),
                    _buildWhatToTrain(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 32, 16),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 20,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.black.withOpacity(0.1),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.blue.withOpacity(0.0),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    );
                    switch (value.toInt()) {
                      case 0:
                        return const Text('Sun', style: style);
                      case 1:
                        return const Text('Mon', style: style);
                      case 2:
                        return const Text('Tue', style: style);
                      case 3:
                        return const Text('Wed', style: style);
                      case 4:
                        return const Text('Thu', style: style);
                      case 5:
                        return const Text('Fri', style: style);
                      case 6:
                        return const Text('Sat', style: style);
                      default:
                        return const Text('');
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    );
                    switch (value.toInt()) {
                      case 20:
                        return const Text('20%', style: style);
                      case 40:
                        return const Text('40%', style: style);
                      case 60:
                        return const Text('60%', style: style);
                      case 80:
                        return const Text('80%', style: style);
                      case 100:
                        return const Text('100%', style: style);
                      default:
                        return const Text('');
                    }
                  },
                  reservedSize: 32,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 100,
            lineBarsData: [
              LineChartBarData(
                spots: workoutData.asMap().entries.map((entry) {
                  return FlSpot(entry.key.toDouble(), entry.value.percentage);
                }).toList(),
                isCurved: true,
                color: Colors.blue,
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 2,
                      color: Colors.blue,
                      strokeWidth: 2,
                      strokeColor: Colors.blue,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDailyWorkoutSchedule(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Daily Workout Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
          TextButton(
            child: const Text('Check', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/workout2');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWhatToTrain() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('What Do You Want To Train', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildTrainingItem('Fullbody Workout', '11 Exercises | 32mins', 'assets/fullbody.png'),
          _buildTrainingItem('Lowerbody Workout', '12 Exercises | 40mins', 'assets/lowerbody.png'),
          _buildTrainingItem('Ab Workout', '14 Exercises | 20mins', 'assets/ab.png'),
        ],
      ),
    );
  }

  Widget _buildTrainingItem(String title, String description, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
