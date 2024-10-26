import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () =>  Navigator.pushReplacementNamed(context, '/dashboard'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
        title: Text('Profile', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                _buildProfileHeader(),
                SizedBox(height: 36),
                _buildInfoSection(),
                SizedBox(height: 36),
                _buildAccountSection(),
                SizedBox(height: 24),
                _buildNotificationSection(),
                SizedBox(height: 24),
                _buildOtherSection(),
              ],
            ),
          ),
          _buildBottomNavBar(),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/profile_image.png'), // Replace with actual asset
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Stefani Wong', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Lose a Fat Program', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
        ElevatedButton(
          child: Text('Edit'),
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
      ],
    );
  }


  Widget _buildInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildInfoItem('180cm', 'Height'),
        _buildInfoItem('65kg', 'Weight'),
        _buildInfoItem('22yo', 'Age'),
      ],
    );
  }

  Widget _buildInfoItem(String value, String label) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return _buildSection('Account', [
      _buildListTile(Icons.person_outline, 'Personal Data'),
      _buildListTile(Icons.star_outline, 'Achievement'),
      _buildListTile(Icons.history, 'Activity History'),
      _buildListTile(Icons.show_chart, 'Workout Progress'),
    ]);
  }

  Widget _buildNotificationSection() {
    return _buildSection('Notification', [
      _buildSwitchTile(Icons.notifications_none, 'Pop-up Notification'),
    ]);
  }

  Widget _buildOtherSection() {
    return _buildSection('Other', [
      _buildListTile(Icons.mail_outline, 'Contact Us'),
      _buildListTile(Icons.lock_outline, 'Privacy Policy'),
      _buildListTile(Icons.settings, 'Settings'),
    ]);
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  Widget _buildSwitchTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Switch(
        value: true,
        onChanged: (bool value) {},
        activeColor: Colors.blue,
      ),
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: 'Calendar'),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white),
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.message_outlined), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline, color: Colors.blue), label: 'Profile'),
      ],
      currentIndex: 4,
    );
  }
}