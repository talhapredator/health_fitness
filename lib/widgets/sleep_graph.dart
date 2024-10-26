// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:health_tracker_app/providers/sleep_data_provider.dart';
//
// class SleepGraph extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final sleepHours = Provider.of<SleepData>(context).sleepHours;
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: LineChart(
//         LineChartData(
//           gridData: FlGridData(
//             show: true,
//             horizontalInterval: 1,
//             getDrawingHorizontalLine: (value) {
//               return FlLine(
//                 color: Colors.grey.withOpacity(0.5),
//                 strokeWidth: 1,
//               );
//             },
//             getDrawingVerticalLine: (value) {
//               return FlLine(
//                 color: Colors.grey.withOpacity(0.5),
//                 strokeWidth: 1,
//               );
//             },
//           ),
//           borderData: FlBorderData(
//             show: true,
//             border: Border.all(
//               color: Colors.grey,
//               width: 1,
//             ),
//           ),
//           titlesData: FlTitlesData(
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
//                   return Text(days[value.toInt()], style: TextStyle(color: Colors.black));
//                 },
//               ),
//             ),
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 interval: 1,
//                 getTitlesWidget: (value, meta) {
//                   return Text('${value.toInt()}h', style: TextStyle(color: Colors.black));
//                 },
//               ),
//             ),
//           ),
//           minX: 0,
//           maxX: 6,
//           minY: 4,
//           maxY: 8,
//           lineBarsData: [
//             LineChartBarData(
//               spots: List.generate(sleepHours.length, (index) => FlSpot(index.toDouble(), sleepHours[index])),
//               isCurved: true,
//               color: Colors.white,
//               barWidth: 4,
//               dotData: FlDotData(show: true),
//               belowBarData: BarAreaData(
//                 show: true,
//                 color: Colors.blue.withOpacity(0.3),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
