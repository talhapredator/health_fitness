import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import for fl_chart
import 'package:health_tracker_app/providers/sleep_data_provider.dart';
import 'package:provider/provider.dart';

class SleepTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sleepData = Provider.of<SleepData>(context);

    return Scaffold(

      body: CustomScrollView(
        slivers: [
          SliverAppBar(

            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/dashboard');
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.black),
                onPressed: () {
                  // Add your menu action here
                },
              ),
            ],

            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Sleep Tracker',
              style: TextStyle(color: Colors.black),

            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildSleepGraph(sleepData),
                _buildLastNightSleepCard(sleepData),
                _buildDailySleepScheduleButton(context),
                _buildTodaySchedule(sleepData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Dynamic Graph based on sleep data
  Widget _buildSleepGraph(SleepData data) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 20, 16),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(

                      ),
                      touchCallback: (FlTouchEvent event, LineTouchResponse? touchResponse) {},
                      handleBuiltInTouches: true,

                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> indicators) {
                        return indicators.map((int index) {
                          final line = FlLine(
                            color: Colors.white.withOpacity(0.5),
                            strokeWidth: 2,
                          );
                          return TouchedSpotIndicatorData(
                            line,
                            FlDotData(show: true),
                          );
                        }).toList();
                      },
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,  // Show only horizontal lines
                      horizontalInterval: 1.95,    // Set the interval for horizontal lines
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.black.withOpacity(0.1),  // Set horizontal grid lines to black
                          strokeWidth: 1,      // Set the thickness of the horizontal lines
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 0, 0),
                              child: Text(
                                days[value.toInt()],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            );
                          },
                          interval: 1,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value % 2 == 0) {
                              return Text(
                                '${value.toInt()}h',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 10,
                                ),
                              );
                            }
                            return Container();
                          },
                          interval: 2,
                          reservedSize: 30,
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    minX: 0,
                    maxX: 6,
                    minY: 2,
                    maxY: 10,
                    lineBarsData: [
                      LineChartBarData(
                        spots: _generateSpots(data.weeklySleepData),
                        isCurved: true,
                        color: Colors.blue[600],
                        barWidth: 2,

                        isStrokeCapRound: true,
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.withOpacity(0.2),
                              Colors.blue.withOpacity(0.05),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        dotData: FlDotData(show: false),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<FlSpot> _generateSpots(List<double> sleepData) {
    return List.generate(sleepData.length, (index) => FlSpot(index.toDouble(), sleepData[index]));
  }

  Widget _buildLastNightSleepCard(SleepData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.blue[600],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage('assets/images/sleep.png'), // Add your faded background image here
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.blue.withOpacity(0.3), // Faded effect
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Last Night Sleep', style: TextStyle(color: Colors.white, fontSize: 18)),
                Text('${data.lastNightSleep}h 20m', style: TextStyle(color: Colors.white, fontSize: 18)),
              ],
            ),
            SizedBox(height: 10),
            // Additional details can be added here if necessary
          ],
        ),
      ),
    );
  }

  Widget _buildDailySleepScheduleButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/schedule'); // Navigate to another screen
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          primary: Colors.blue[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Daily Sleep Schedule', style: TextStyle(fontSize: 16)),
            Icon(Icons.check_circle, color: Colors.white), // Check icon instead of toggle
          ],
        ),
      ),
    );
  }

  Widget _buildTodaySchedule(SleepData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Today Schedule', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildScheduleItem(
            icon: Icons.bedtime_rounded,
            title: 'Bedtime',
            time: data.bedtime,
            durationText: 'in ${data.timeUntilBed.inHours} hours ${data.timeUntilBed.inMinutes % 60} minutes',
            toggleValue: true,
          ),
          SizedBox(height: 10),
          _buildScheduleItem(
            icon: Icons.alarm,
            title: 'Alarm',
            time: data.alarmTime,
            durationText: 'in ${data.timeUntilAlarm.inHours} hours ${data.timeUntilAlarm.inMinutes % 60} minutes',
            toggleValue: false,
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleItem({
    required IconData icon,
    required String title,
    required String time,
    required String durationText,
    required bool toggleValue,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, size: 30, color: Colors.blue),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(time, style: TextStyle(fontSize: 14, color: Colors.black)),
                  Text(durationText, style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
          Switch(value: toggleValue, onChanged: (val) {}),
        ],
      ),
    );
  }
}
