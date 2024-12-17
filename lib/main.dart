import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/home_page.dart';
import 'screens/add_user_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/list_items_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Balance',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/signIn': (context) => const SignInScreen(),
        '/home': (context) => const HomePage(),
        '/addUser': (context) => const AddUserScreen(),
        '/addTask': (context) => const AddTaskScreen(),
        '/notifications': (context) => const NotificationsScreen(), 
        '/listItems': (context) => const ListItemsScreen(),
      },
    );
  }
}
