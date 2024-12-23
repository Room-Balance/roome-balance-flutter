import 'package:flutter/material.dart';
import 'screens/notifications_screen.dart';
import 'screens/list_items_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/sign_in_screen.dart';
import 'screens/home_page.dart';
import 'screens/add_user_screen.dart';
import 'screens/add_task_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/change_password.dart';
import 'screens/sign_up_screen.dart';
import 'screens/forgot_password.dart';
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
        '/forgotPassword': (context) => ForgotPasswordScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/changePassword': (context) => ChangePasswordScreen(),
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
          case '/addTask': // AddTask rotası için tanım
            final arguments = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => AddTaskScreen(
                users: arguments['users'] as List<Map<String, dynamic>>,
                onTaskAdded: arguments['onTaskAdded'] as Function(Task),
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}
