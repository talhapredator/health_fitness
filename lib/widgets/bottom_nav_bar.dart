import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the current index from Provider
    int currentIndex = Provider.of<ValueNotifier<int>>(context).value;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            color: currentIndex == 0 ? Colors.blue : Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.fitness_center,
            color: currentIndex == 1 ? Colors.blue : Colors.black,
          ),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.camera_alt_outlined, color: Colors.white),
          ),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.nightlight_outlined,
            color: currentIndex == 3 ? Colors.blue : Colors.black,
          ),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            color: currentIndex == 4 ? Colors.blue : Colors.black,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex, // Use current index from Provider
      onTap: (index) {
        // Update the current index and navigate to different screens
        Provider.of<ValueNotifier<int>>(context, listen: false).value = index;

        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/home');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/workout');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/photo');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/sleep');
            break;
          case 4:
            Navigator.pushReplacementNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
