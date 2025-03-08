// ignore_for_file: use_build_context_synchronously

import 'package:academy_lms_app/screens/tab_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    donLogin();
    super.initState();
  }

  void donLogin() {
    Future.delayed(const Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const TabsScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          child: Container(
            margin: const EdgeInsets.all(50.0),
            child: Image.asset(
              'assets/images/light_logo.png',
              // fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
