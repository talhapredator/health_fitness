import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CaloriesWidget extends StatelessWidget {
  final double caloriesTaken;
  final double totalCalories;

  CaloriesWidget({required this.caloriesTaken, required this.totalCalories});

  @override
  Widget build(BuildContext context) {
    double caloriesLeft = totalCalories - caloriesTaken;
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calories',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${caloriesTaken.toInt()} KCal',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 0),
          Container(
            height: 150,
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 30,
                sections: _buildPieChartSections(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              '${caloriesLeft.toInt()} KCal left',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return [
      PieChartSectionData(
        color: Colors.blueAccent,
        value: caloriesTaken,
        title: '${caloriesTaken.toInt()}',
        radius: 30,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: Colors.grey.withOpacity(0.2),
        value: totalCalories - caloriesTaken,
        title: '',
        radius: 30,
      ),
    ];
  }
}
