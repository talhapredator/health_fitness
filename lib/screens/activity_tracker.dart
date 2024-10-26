import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivityTrackerModel extends ChangeNotifier {
  int waterIntake = 0;
  int steps = 0;
  List<int> weeklyActivity = [60, 80, 65, 90, 70, 85, 75];
  List<ActivityItem> latestActivities = [
    ActivityItem(icon: '💧', title: 'Drinking 300ml Water', time: 'About 3 minutes ago'),
    ActivityItem(icon: '🍎', title: 'Eat Snack (1 fiber)', time: 'About 10 minutes ago'),
  ];

  void updateWaterIntake(int amount) {
    waterIntake += amount;
    notifyListeners();
  }

  void updateSteps(int count) {
    steps += count;
    notifyListeners();
  }
}

class ActivityItem {
  final String icon;
  final String title;
  final String time;

  ActivityItem({required this.icon, required this.title, required this.time});
}

class ActivityTrackerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ActivityTrackerModel(),
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildHeader(context),
                    SizedBox(height: 20),
                    _buildTodayTarget(),
                    SizedBox(height: 20),
                    _buildActivityProgress(),
                    SizedBox(height: 20),
                    _buildLatestActivity(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
        Expanded(
          child: Text(
            'Activity Tracker',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTodayTarget() {
    return Consumer<ActivityTrackerModel>(
      builder: (context, model, child) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today Target',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTargetItem(Icons.water_drop, '${model.waterIntake} ml', 'Water Intake'),
                  _buildTargetItem(Icons.directions_walk, '${model.steps}', 'Foot Steps'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTargetItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.blue, size: 24),
        ),
        SizedBox(height: 8),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildActivityProgress() {
    return Consumer<ActivityTrackerModel>(
      builder: (context, model, child) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Activity Progress',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text('Weekly', style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (index) {
                    return _buildActivityBar(
                      height: model.weeklyActivity[index].toDouble(),
                      day: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][index],
                      isSelected: index == 4,  // Assuming Thursday is selected
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActivityBar({required double height, required String day, bool isSelected = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: height,
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue : Colors.blue[100],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        SizedBox(height: 8),
        Text(day, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildLatestActivity() {
    return Consumer<ActivityTrackerModel>(
      builder: (context, model, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest Activity',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('See more', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            SizedBox(height: 8),
            ...model.latestActivities.map((activity) => _buildActivityItem(activity)).toList(),
          ],
        );
      },
    );
  }

  Widget _buildActivityItem(ActivityItem activity) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Text(activity.icon, style: TextStyle(fontSize: 24)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(activity.title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(activity.time, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }
}