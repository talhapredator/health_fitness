
import 'package:flutter/material.dart';
import 'package:health_tracker_app/widgets/water_intake.dart';
import 'package:health_tracker_app/widgets/calories.dart';
import 'package:health_tracker_app/widgets/bottom_nav_bar.dart'; // Import the BottomNavBar

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Welcome Back,',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome and Name
              Text(
                'Stefani Wong',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 40),
              // BMI Card (left as is)
              _buildBmiCard(),
              SizedBox(height: 40),
              // Today Target Card (left as is)
              _buildTodayTargetCard(context),
              SizedBox(height: 40),
              // Activity Status Title
              Text(
                'Activity Status',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Heart Rate Card (left as is)
              _buildHeartRateCard(),
              SizedBox(height: 40),
              // Water Intake, Sleep, and Calories Cards
              _buildStatusGrid(),
              SizedBox(height: 40),  // Padding at the bottom for more widgets later
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(), // Add BottomNavBar here
    );
  }

  Widget _buildBmiCard() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [Color(0xff92A3FD),  Color(0xff92A3FD)], // Custom gradient colors
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BMI (Body Mass Index)',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'You have a normal weight',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {},
              child: Text('View More', style: TextStyle(color: Colors.white70)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayTargetCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xff9DCEFF).withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Shadow color
            spreadRadius: 1, // Spread radius of the shadow
            blurRadius: 2, // Blur radius of the shadow
            offset: Offset(0, 2), // Offset of the shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Today's Schedule", style: TextStyle(fontWeight: FontWeight.bold)),
          TextButton(
            child: const Text('Check', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/activity');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeartRateCard() {
    return Container(
      width: double.infinity, // Full width of the parent
      height: 135, // Set a fixed height to ensure visibility
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        // Background image configuration
        image: DecorationImage(
          image: AssetImage('assets/images/hearbeat.jpg'), // Update with your image path
          fit: BoxFit.cover, // Cover the entire container
        ),
      ),
      child: Container(
        // Additional container to apply gradient and padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Color(0xff9DCEFF).withOpacity(0.92), // Semi-transparent gradient color
              Color(0xff9DCEFF),
            ],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Heart Rate',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '78 BPM',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '3 mins ago',
                style: TextStyle(color: Colors.purpleAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStatusGrid() {
    return Column(
      children: [
        // Row for Water Intake (takes full width)
        Row(
          children: [
            Expanded(
              child: WaterIntakeWidget(
                intakeValue: 50,
                timeUpdates: {
                  '6am - 8am': '600ml',
                  '9am - 11am': '500ml',
                  '11am - 2pm': '1000ml',
                  '2pm - 4pm': '700ml',
                  '4pm - now': '600ml',
                },// Progress value
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        // Row for Sleep and Calories
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildStatusCard('Sleep', '8h 20m', 'Last night\'s sleep'),
            ),
            SizedBox(width: 20),
            Expanded(
              child: CaloriesWidget(
                caloriesTaken: 760, // Actual value
                totalCalories: 1000, // Actual value
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusCard(String title, String value, String subtitle) {
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
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            subtitle,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
