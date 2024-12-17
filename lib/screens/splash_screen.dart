import 'package:flutter/material.dart';
import 'dart:async'; // Timer kullanmak için gerekli

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // after 3 secs SignInScreen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/signIn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A3C34), // Arkaplan rengi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
           
            Image.asset(
              'assets/images/splash_screen_logo.png',
              width: 150,
              height: 150,
            ), 
            
            const SizedBox(height: 20),
            // name of the app
            const Text(
              'HOME BALANCE',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
