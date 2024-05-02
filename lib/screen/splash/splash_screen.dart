import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    // final auth = FirebaseAuth.instance;
    // final user = auth.currentUser;

    // if (user != null) {
    Timer(const Duration(seconds: 3), () {
      Get.off(() => HomeScreen());
    });
    // } else {
    //   Timer(const Duration(seconds: 3), () {
    //     Get.off(() => const LoginScreen());
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
