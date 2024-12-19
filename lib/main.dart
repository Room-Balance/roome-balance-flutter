import 'package:flutter/material.dart';
import 'screens/notifications_screen.dart' as notifications;
import 'screens/list_items_screen.dart' as listItems;
import 'screens/splash_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/home_page.dart';
import 'screens/add_user_screen.dart';
import 'screens/add_task_screen.dart';

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
      initialRoute: '/home',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/signIn': (context) => SignInScreen(),
        '/home': (context) => HomePage(),
        '/addUser': (context) => AddUserScreen(),
        '/addTask': (context) => AddTaskScreen(),
        '/notifications': (context) => notifications.NotificationsScreen(),
        '/listItems': (context) => listItems.ListItemsScreen(),
      },
    );
  }
}
