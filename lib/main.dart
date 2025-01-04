import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// Screen imports
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
import 'screens/settings_screen.dart';
import '../models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home Balance',
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.grey),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('tr'), // Turkish
      ],
      initialRoute: '/splash',
      routes: _buildRoutes(),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      '/splash': (context) => const SplashScreen(),
      '/signIn': (context) => const SignInScreen(),
      '/home': (context) => const HomePage(),
      '/profile': (context) => const ProfileScreen(),
      '/forgotPassword': (context) => const ForgotPasswordScreen(),
      '/signUp': (context) => const SignUpScreen(),
      '/changePassword': (context) => const ChangePasswordScreen(),
      '/settings': (context) => SettingsScreen(),
    };
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/calendar':
        if (settings.arguments is List<Task>) {
          final tasks = settings.arguments as List<Task>;
          return MaterialPageRoute(
            builder: (context) => CalendarScreen(tasks: tasks),
          );
        }
        return _errorRoute('Invalid arguments for /calendar');
      case '/notifications':
        if (settings.arguments is List<Task>) {
          final tasks = settings.arguments as List<Task>;
          return MaterialPageRoute(
            builder: (context) => NotificationsScreen(tasks: tasks),
          );
        }
        return _errorRoute('Invalid arguments for /notifications');
      case '/addTask':
        if (settings.arguments is Map<String, dynamic>) {
          final arguments = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => AddTaskScreen(
              users: arguments['users'] as List<Map<String, dynamic>>,
              onTaskAdded: arguments['onTaskAdded'] as Function(Task),
            ),
          );
        }
        return _errorRoute('Invalid arguments for /addTask');
      default:
        return _errorRoute('Route not found');
    }
  }

  Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(
            message,
            style: const TextStyle(fontSize: 18, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
