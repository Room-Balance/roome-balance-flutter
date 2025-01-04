import 'package:flutter/material.dart';
import 'package:home_balance_flutter/screens/notifications_screen.dart';
import 'package:home_balance_flutter/screens/list_items_screen.dart';
import 'package:home_balance_flutter/screens/splash_screen.dart';
import 'package:home_balance_flutter/screens/sign_in_screen.dart';
import 'package:home_balance_flutter/screens/home_page.dart';
import 'package:home_balance_flutter/screens/add_user_screen.dart';
import 'package:home_balance_flutter/screens/add_task_screen.dart';
import 'package:home_balance_flutter/screens/calendar_screen.dart';
import 'package:home_balance_flutter/screens/profile_screen.dart';
import 'package:home_balance_flutter/screens/change_password.dart';
import 'package:home_balance_flutter/screens/sign_up_screen.dart';
import 'package:home_balance_flutter/screens/forgot_password.dart';
import 'package:home_balance_flutter/screens/settings_screen.dart';


Map<String, WidgetBuilder> appRoutes = {
  '/splash': (context) => const SplashScreen(),
  '/signIn': (context) => const SignInScreen(),
  '/home': (context) => const HomePage(),
  '/profile': (context) => const ProfileScreen(),
  '/forgotPassword': (context) => const ForgotPasswordScreen(),
  '/signUp': (context) => const SignUpScreen(),
  '/changePassword': (context) => const ChangePasswordScreen(),
  '/settings': (context) => SettingsScreen(),
};
