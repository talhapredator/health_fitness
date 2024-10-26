import 'package:flutter/material.dart';
import 'package:health_tracker_app/providers/alarm_provider.dart';
import 'package:health_tracker_app/providers/sleep_data_provider.dart';
import 'package:health_tracker_app/providers/sleep_schedule_provider.dart';
import 'package:health_tracker_app/screens/activity_tracker.dart';
import 'package:health_tracker_app/screens/alarm_screen.dart';
import 'package:health_tracker_app/screens/home_screen.dart';
import 'package:health_tracker_app/screens/info_screen.dart';
import 'package:health_tracker_app/screens/login_screen.dart';
import 'package:health_tracker_app/screens/profile_screen.dart';
import 'package:health_tracker_app/screens/register_screen.dart';
import 'package:health_tracker_app/screens/register_screen_2.dart';
import 'package:health_tracker_app/screens/sleep_schedule_screen.dart';
import 'package:health_tracker_app/screens/sleep_tracker_screen.dart';
import 'package:health_tracker_app/screens/workout2_screen.dart';
import 'package:health_tracker_app/screens/workout_detail_screen.dart';
import 'package:health_tracker_app/screens/workout_screen.dart';
import 'package:health_tracker_app/providers/workout_provider.dart';
import 'package:health_tracker_app/providers/workout_detail_provider.dart';
import 'package:health_tracker_app/providers/auth_provider.dart';
import 'package:health_tracker_app/widgets/bottom_nav_bar.dart';
import 'package:health_tracker_app/screens/photo_screen.dart';
import 'package:provider/provider.dart';
import 'providers/app_state.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutDetailProvider()),
        ChangeNotifierProvider(create: (_) => SleepData()),// App state provider
        ChangeNotifierProvider(create: (_) => SleepScheduleProvider()),
        ChangeNotifierProvider(create: (_) => AlarmProvider()),
        ChangeNotifierProvider(create: (_) => PhotosProvider()),
        ChangeNotifierProvider(
          create: (_) => ValueNotifier<int>(0), // ValueNotifier for currentIndex
        ),
      ],
      child: MaterialApp(
        title: 'Health Fitness Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
        routes: {
          '/home': (context) => SplashScreen(),
          '/register': (context) => RegisterScreen(),
          '/register2': (context) => RegisterScreen2(),
          '/info': (context) => InfoScreen(),
          '/login': (context) => LoginScreen(),
          '/dashboard': (context) => HomeScreen(),
          '/activity': (context) => ActivityTrackerScreen(),
          '/profile': (context) => ProfileScreen(),
          '/workout': (context) => WorkoutTrackerScreen(),
          '/workout2': (context) => WorkoutScreen(),
          '/workdetail': (context) => WorkoutDetailScreen(),
          '/sleep': (context) => SleepTrackerScreen(),
          '/schedule': (context) => SleepScheduleScreen(),
          '/alarm': (context) => AddAlarmScreen(),
          '/photo': (context) => PhotosScreen(),
        },
      ),
    );
  }
}
