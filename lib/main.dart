import 'package:flutter/material.dart';
import 'screens/notifications_screen.dart';
import 'screens/list_items_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/home_page.dart';
import 'screens/profile_screen.dart';
import 'screens/calendar_screen.dart';
import '../models/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Balance',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/signIn': (context) => SignInScreen(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfileScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/calendar':
            final List<Task> tasks = settings.arguments as List<Task>;
            return MaterialPageRoute(
              builder: (context) => CalendarScreen(tasks: tasks),
            );
          case '/notifications':
            final List<Task> tasks = settings.arguments as List<Task>;
            return MaterialPageRoute(
              builder: (context) => NotificationsScreen(tasks: tasks),
            );
          default:
            return null;
        }
      },
    );
  }
}
