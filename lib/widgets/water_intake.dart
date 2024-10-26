import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

class WaterIntakeWidget extends StatelessWidget {
  final double intakeValue; // intake in percentage
  final double dailyGoalLiters; // total liters to intake in a day
  final Map<String, String> timeUpdates; // Real-time updates (time and ml)

  WaterIntakeWidget({
    required this.intakeValue,
    this.dailyGoalLiters = 4.0,
    required this.timeUpdates,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          // Water intake progress bar
          Container(
            height: 200,
            width: 60,
            child: LiquidLinearProgressIndicator(
              value: intakeValue / 100, // intakeValue in percentage
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(Color(0xff92A3FD)),
              borderRadius: 12.0,
              direction: Axis.vertical,
            ),
          ),
          SizedBox(width: 20),
          // Real-time updates section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Water Intake',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '${dailyGoalLiters.toInt()} Liters',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Real time updates',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // Real-time updates list
                Column(
                  children: timeUpdates.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.circle,
                                size: 10,
                                color: entry.key == '4pm - now'
                                    ? Colors.purpleAccent
                                    : Colors.purple.withOpacity(0.5),
                              ),
                              SizedBox(width: 5),
                              Text(
                                entry.key,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: 14,
                              color: entry.key == '4pm - now'
                                  ? Colors.purpleAccent
                                  : Colors.purple.withOpacity(0.7),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
