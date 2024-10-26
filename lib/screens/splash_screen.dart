import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DateTime? _lastBackPressTime;  // To keep track of last back press time

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final backButtonHasNotBeenPressedOrHasBeenPressedLongTimeAgo =
            _lastBackPressTime == null ||
                now.difference(_lastBackPressTime!) > Duration(seconds: 2);

        if (backButtonHasNotBeenPressedOrHasBeenPressedLongTimeAgo) {
          // Show snackbar asking the user to swipe again to exit
          _lastBackPressTime = now;
          final snackBar = SnackBar(
            content: Text(
              'Swipe again to exit',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: Duration(seconds: 2), // Duration before the SnackBar disappears
            backgroundColor: Colors.blueAccent.withOpacity(0.8), // Semi-transparent background
            behavior: SnackBarBehavior.floating, // Floating SnackBar behavior
            margin: EdgeInsets.only(
              bottom: 50.0, // Moves the SnackBar up from the bottom of the screen
              left: 50.0,
              right: 50.0,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Rounded edges
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          return Future.value(false); // Do not exit the app yet
        }

        return Future.value(true); // Exit the app if swiped within 2 seconds
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Fitness',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'X',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Everybody Can Train',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.purpleAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
